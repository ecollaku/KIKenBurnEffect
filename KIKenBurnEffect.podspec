Pod::Spec.new do |s|

          s.name               = "KIKenBurnEffect"
          
          s.version            = "1.0.0"
            
          s.summary      = "Continuous Ken Burn effect"
          s.description  = "KI Ken Burn effect provides a type of panning and zooming effect used in video production from still imagery. It adds a cinematic feeling to the App screen"
          s.homepage     = "https://github.com/ecollaku/KIKenBurnEffect/"
          s.license      = "MIT"
          s.author              = "KI labs GmbH"
          s.social_media_url   = "https://twitter.com/ki_labs_hq"
          
          s.platform            = :ios, "11.4"
          
          s.source              = { :git => "https://github.com/ecollaku/KIKenBurnEffect.git", :tag => s.version }
          
          s.source_files     = "KIKenBurnEffect", "KIKenBurnEffect/**/*.{h,m,swift}"
    end


  