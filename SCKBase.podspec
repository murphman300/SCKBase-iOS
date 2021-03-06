Pod::Spec.new do |s|
  s.name         = "SCKBase"
  s.version      = "3.0.0"
  s.summary      = "SCKBase is the base of apps Spotit, Checkout and Kapt."
  s.description  = "SCKBase is the base for apps Spotit, Checkout and Kapt."
  s.homepage     = "https://github.com/murphman300/SCKBase-iOS"
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
      LICENSE
    }
  s.author             = { "murphman300" => "jeanlouismurphy@gmail.com" }
  #s.platform     = :ios
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/murphman300/SCKBase-iOS.git", :tag => "#{s.version}" }
  s.source_files  = "SCKBase", "SCKBase/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
  s.pod_target_xcconfig = {"SWIFT_VERSION" => "3.0"}
  # s.public_header_files = "Classes/**/*.h"

end
