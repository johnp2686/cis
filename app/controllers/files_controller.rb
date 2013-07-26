class FilesController < ApplicationController
def show
	asset = PolicyPhoto.find(params[:id])
	if can?(:view, asset.claim.user)
		send_file asset.image.path, :filename => asset.image
		# :content_type => asset.asset_content_type
	else
		flash[:alert] = "The asset you were looking for could not be found."
		redirect_to root_path
	end
end

def new
	@claim = Claim.new
	asset = @claim.policy_photos.build

	image = PolicyPhoto.new
	render :partial => "files/form",
	:locals => { :image => image }
end


end
