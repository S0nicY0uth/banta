class ApplicationController < ActionController::Base

    def ensure_access_token
        unless session[:access_token]
            redirect_to oauth2_client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/githuboauth/oauth2_callback')
        end
    end
    
    def oauth2_client
        OAuth2::Client.new(
            "33a9db5814e3348893ed",
            "87fcb5fd51936aac177e765266a8d69e95f5c143",
            :authorize_url => '/login/oauth/authorize',
            :token_url => '/login/oauth/access_token',
            :site => 'https://github.com'
        )
    end
    

    def after_sign_in_path_for(resource_or_scope)
        current_user
    end
end
