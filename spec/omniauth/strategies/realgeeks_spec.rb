require 'spec_helper'

describe OmniAuth::Strategies::RealGeeks do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  let(:alternative_site)          { 'https://some.other.site.com/oauth' }
  let(:alternative_authorize_url) { 'https://some.other.site.com/oauth/authorize' }
  let(:alternative_token_url)     { 'https://some.other.site.com/oauth/token' }
  let(:alternative) do
    OmniAuth::Strategies::RealGeeks.new('realgeeks_KEY', 'realgeeks_SECRET',
        {
            :client_options => {
                :site => alternative_site,
                :authorize_url => alternative_authorize_url,
                :token_url => alternative_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::RealGeeks.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://login.realgeeks.com/oauth")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('https://login.realgeeks.com/oauth/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('https://login.realgeeks.com/oauth/token')
    end

    describe "should be overrideable" do
      it "for site" do
        alternative.options.client_options.site.should eq(alternative_site)
      end

      it "for authorize url" do
        alternative.options.client_options.authorize_url.should eq(alternative_authorize_url)
      end

      it "for token url" do
        alternative.options.client_options.token_url.should eq(alternative_token_url)
      end
    end
  end

  context "#email" do
    it "should return email from raw_info if available" do
      allow(subject).to receive(:raw_info).and_return({'email' => 'you@example.com'})
      subject.email.should eq('you@example.com')
    end

    it "should return nil if there is no raw_info and email access is not allowed" do
      allow(subject).to receive(:raw_info).and_return({})
      subject.email.should be_nil
    end

  end

  context "#raw_info" do
    it "should use relative paths" do
      access_token.should_receive(:get).with('user').and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end
end
