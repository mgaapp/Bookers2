class HomesController < ApplicationController
allow_unauthenticated_access only: [:top]
layout false, only: [:about]

    def top
    
    end
    def about
    end
end
