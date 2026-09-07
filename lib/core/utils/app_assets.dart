class AppImages {
//###################################################### IMAGES ####################################################################
static const String AppLogo="assets/images/AppLogo.png";
static const String AvailableNow="assets/images/AvailableNow.png";
static const String Cast="assets/images/Cast.png";
static const String Empty="assets/images/Empty.png";
static const String ForgetPasswordVector="assets/images/ForgetPasswordVector.png";
static const String MovieCard="assets/images/MovieCard.png";
static const String PlayButton="assets/images/PlayButton.png";
static const String RouteLogo="assets/images/RouteLogo.png";
static const String Screenshots1="assets/images/Screenshots1.png";
static const String Screenshots2="assets/images/Screenshots2.png";
static const String Screenshots3="assets/images/Screenshots3.png";
static const String WatchNow="assets/images/WatchNow.png";
//########################################################################
static const String Profile01="assets/images/ProfileAvatars/Profile01.png";
static const String Profile02="assets/images/ProfileAvatars/Profile02.png";
static const String Profile03="assets/images/ProfileAvatars/Profile03.png";
static const String Profile04="assets/images/ProfileAvatars/Profile04.png";
static const String Profile05="assets/images/ProfileAvatars/Profile05.png";
static const String Profile06="assets/images/ProfileAvatars/Profile06.png";
static const String Profile07="assets/images/ProfileAvatars/Profile07.png";
static const String Profile08="assets/images/ProfileAvatars/Profile08.png";
static const String Profile09="assets/images/ProfileAvatars/Profile09.png";
//########################################################################
static const List<String> ProfileAvatars = [
  Profile01, Profile02, Profile03,
  Profile04, Profile05, Profile06,
  Profile07, Profile08, Profile09,
];

/// Maps the 1-based `avatar` index stored on UserModel/Firestore to its asset path.
static String avatarByIndex(int index) {
  if (index < 1 || index > ProfileAvatars.length) return Profile01;
  return ProfileAvatars[index - 1];
}
  static int indexByAvatar(String avatarPath) {
    final index = ProfileAvatars.indexOf(avatarPath);

    if (index == -1) return 1;

    return index + 1;
  }
//########################################################################
static const String MoviesPosters="assets/images/OnBoarding/MoviesPosters.png";
static const String OnBoarding1="assets/images/OnBoarding/OnBoarding1.png";
static const String OnBoarding2="assets/images/OnBoarding/OnBoarding2.png";
static const String OnBoarding3="assets/images/OnBoarding/OnBoarding3.png";
static const String OnBoarding4="assets/images/OnBoarding/OnBoarding4.png";
static const String OnBoarding5="assets/images/OnBoarding/OnBoarding5.png";
//########################################################################
static const String MoviePoster1="assets/images/MoviePosters/MoviePoster1.png";
static const String MoviePoster2="assets/images/MoviePosters/MoviePoster2.png";
static const String MoviePoster3="assets/images/MoviePosters/MoviePoster3.png";
static const String MoviePoster4="assets/images/MoviePosters/MoviePoster4.png";
static const String MoviePoster5="assets/images/MoviePosters/MoviePoster5.png";
static const String MoviePoster6="assets/images/MoviePosters/MoviePoster6.png";
//################################################################################
}




class AppIcons{
  static const String ArrowBack="assets/icons/ArrowBack.png";
  static const String Back="assets/icons/Back.png";
  static const String Bookmark="assets/icons/Bookmark.png";
  static const String EG="assets/icons/EG.png";
  static const String Email="assets/icons/Email.png";
  static const String Exit="assets/icons/Exit.png";
  static const String Explore="assets/icons/Explore.png";
  static const String ExploreSolid="assets/icons/ExploreSolid.png";
  static const String Favourite="assets/icons/Favourite.png";
  static const String Google="assets/icons/Google.png";
  static const String Hide="assets/icons/Hide.png";
  static const String History="assets/icons/History.png";
  static const String Home="assets/icons/Home.png";
  static const String HomeSolid="assets/icons/HomeSolid.png";
  static const String LR="assets/icons/LR.png";
  static const String Name="assets/icons/Name.png";
  static const String Password="assets/icons/Password.png";
  static const String Person="assets/icons/Person.png";
  static const String Phone="assets/icons/Phone.png";
  static const String Profile="assets/icons/Profile.png";
  static const String ProfileSolid="assets/icons/ProfileSolid.png";
  static const String Search="assets/icons/Search.png";
  static const String SearchSolid="assets/icons/SearchSolid.png";
  static const String Star="assets/icons/Star.png";
  static const String Watch="assets/icons/Watch.png";
  static const String WatchList="assets/icons/WatchList.png";
  static const String imagePlaceholder="assets/images/image placeholder.jpg";

}
