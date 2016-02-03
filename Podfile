# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

def default_pods
pod 'AFNetworking', '~> 3.0'
pod 'JSONModel'
end

def testing_pods
pod 'OCMock', '~> 3.2'
end

target 'MVC' do
default_pods
end

target 'MVCTests' do
testing_pods
end

target 'MVP' do
default_pods
end

target 'MVPTests' do
testing_pods
end

target 'MVVM' do
default_pods
pod 'ReactiveCocoa', '~> 4.0'
end

target 'MVVMTests' do
testing_pods
end

target 'VIPER' do
default_pods
pod 'Typhoon', '~> 3.4'
end

target 'VIPERTests' do
testing_pods
end

