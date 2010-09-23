require 'test_helper'

class ResumesControllerTest < ActionController::TestCase
  
  test 'create' do
    Resume.any_instance.expects(:save).returns(true)
    resource = resumes(:basic)
    post :create, :resource => resource.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Resume.any_instance.expects(:save).returns(false)
    resource = resumes(:basic)
    post :create, :resource => resource.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Resume.any_instance.expects(:save).returns(true)
    resource = resumes(:basic)
    put :update, :id => resumes(:basic).to_param, :resource => resource.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Resume.any_instance.expects(:save).returns(false)
    resource = resumes(:basic)
    put :update, :id => resumes(:basic).to_param, :resource => resource.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Resume.any_instance.expects(:destroy).returns(true)
    resource = resumes(:basic)
    delete :destroy, :id => resource.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    resource = resumes(:basic)
    get :edit, :id => resource.to_param
    assert_response :success
  end
  
  test 'show' do
    resource = resumes(:basic)
    get :show, :id => resource.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:resumes)
  end
  
end