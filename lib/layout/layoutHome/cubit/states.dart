abstract class LayoutStates{}

class LayoutInitStates extends LayoutStates{}

class LayoutGetUserLoadingStates extends LayoutStates{}

class LayoutGetUserSuccessStates extends LayoutStates{

}

class LayoutGetUserErrorStates extends LayoutStates{
  final String error;

  LayoutGetUserErrorStates(this.error);
}

class LayoutChangeNavBarSuccessStates extends LayoutStates{}

class LayoutChangeNavBarPostSuccessStates extends LayoutStates{}

class EditProfileGetPickerCoverSuccessStates extends  LayoutStates{}

class EditProfileGetPickerCoverErrorStates extends  LayoutStates{

}

class EditProfileGetPickerProfileSuccessStates extends  LayoutStates{}

class EditProfileGetPickerProfileErrorStates extends  LayoutStates{

}
class EditProfileUploadImageProfileSuccessStates extends  LayoutStates{}

class EditProfileUploadImageProfileErrorStates extends  LayoutStates{}

class EditProfileUploadImageCoverSuccessStates extends  LayoutStates{}

class EditProfileUploadImageCoverErrorStates extends  LayoutStates{}

class EditProfileUserUpdateLoadingStates extends  LayoutStates{}

class EditProfileUserUpdateSuccessStates extends  LayoutStates{}

class EditProfileUserUpdateErrorStates extends  LayoutStates{}

class GetImagePostSuccessStates extends  LayoutStates{}

class GetImagePostErrorStates extends  LayoutStates{}


class CreateNewPostLoadingStates extends  LayoutStates{}

class CreateNewPostSuccessStates extends  LayoutStates{}

class CreateNewPostErrorStates extends  LayoutStates{}


class UploadNewPostImageErrorStates extends  LayoutStates{}


class RemovePostSuccessStates extends  LayoutStates{}



class EditProfileGetNewPostLoadingStates extends  LayoutStates{}

class EditProfileGetNewPostSuccessStates extends  LayoutStates{}

class EditProfileGetNewPostErrorStates extends  LayoutStates{}
//LikesPost
class LikesPostLoadingStates extends  LayoutStates{}

class LikesPostSuccessStates extends  LayoutStates{}

class LikesPostPostErrorStates extends  LayoutStates{}
//RemoveLikes

class RemoveLikesSuccessStates extends  LayoutStates{}

class RemoveLikesErrorStates extends  LayoutStates{}


//chats

class GetUserAllLoadingStates extends LayoutStates{}

class GetUserAllSuccessStates extends LayoutStates{}

class GetUserAllErrorStates extends LayoutStates{}

//chatsDetails
class SendChatLoadingStates extends LayoutStates{}

class SendChatSuccessStates extends LayoutStates{}

class SendChatErrorStates extends LayoutStates{}


class GetChatSuccessStates extends LayoutStates{}
//psots realtime
class GetlikesSuccessStates extends LayoutStates{}

//post likes realtime
class UpdateNewPostLoadingStates extends LayoutStates{}

class UpdateNewPostSuccessStates extends LayoutStates{}

class UpdateNewPostErrorStates extends LayoutStates{}

// chat ++image

class ImagePickerChatSuccessStates extends LayoutStates{}

class ImagePickerChatErrorStates extends LayoutStates{}


class SendImageChatLoadingStates extends LayoutStates{}

class SendImageChatSuccessStates extends LayoutStates{}

class SendImageChatErrorStates extends LayoutStates{}
