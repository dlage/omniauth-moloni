require 'spec_helper'

describe OmniAuth::Strategies::Moloni do
  let(:moloni_user_path) { 'users/getMe/' }
  let(:access_token) { instance_double('AccessToken', :options => {}, :[] => moloni_user_path) }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  let(:sandbox_site) { 'https://api.moloni.pt/sandbox/' }
  let(:sandbox_authorize_url) { 'https://api.moloni.pt/sandbox/authorize/' }
  let(:sandbox_token_url) { 'https://api.moloni.pt/sandbox/grant/' }
  let(:sandbox) do
    OmniAuth::Strategies::Moloni.new(
      'MOLONI_KEY', 'MOLONI_SECRET',
      {
        :client_options => {
          :site => sandbox_site,
          :authorize_url => sandbox_authorize_url,
          :token_url => sandbox_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::Moloni.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://api.moloni.pt/v1/')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://api.moloni.pt/v1/authorize/')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://api.moloni.pt/v1/grant/')
    end

    describe 'should be overrideable' do
      it 'for site' do
        expect(sandbox.options.client_options.site).to eq(sandbox_site)
      end

      it 'for authorize url' do
        expect(sandbox.options.client_options.authorize_url).to eq(sandbox_authorize_url)
      end

      it 'for token url' do
        expect(sandbox.options.client_options.token_url).to eq(sandbox_token_url)
      end
    end
  end

  context '#email' do
    it 'should return email from raw_info if available' do
      allow(subject).to receive(:raw_info).and_return({ 'email' => 'you@example.com' })
      expect(subject.email).to eq('you@example.com')
    end

    it 'should return nil if there is no raw_info and email access is not allowed' do
      allow(subject).to receive(:raw_info).and_return({})
      expect(subject.email).to be_nil
    end
  end

  context '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:get).with(moloni_user_path).and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end

    it 'should use the header auth mode' do
      expect(access_token).to receive(:get).with(moloni_user_path).and_return(response)
      subject.raw_info
      expect(access_token.options[:mode]).to eq(:header)
    end
  end

  context '#info.email' do
    it 'should use any available email' do
      allow(subject).to receive(:raw_info).and_return({ 'email' => 'you@example.com' })
      allow(subject).to receive(:email).and_return('you@example.com')
      expect(subject.info['email']).to eq('you@example.com')
    end
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')

      expect(subject.callback_url).to eq('https://example.com/sub_uri/auth/moloni/callback')
    end
  end
end
