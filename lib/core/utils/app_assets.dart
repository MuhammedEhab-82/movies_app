class AppImages {
  //###################################################### IMAGES ####################################################################
  static const String appLogo = "assets/images/AppLogo.png";
  static const String availableNow = "assets/images/AvailableNow.png";
  static const String cast = "assets/images/Cast.png";
  static const String empty = "assets/images/Empty.png";
  static const String forgetPasswordVector = "assets/images/ForgetPasswordVector.png";
  static const String movieCard = "assets/images/MovieCard.png";
  static const String playButton = "assets/images/PlayButton.png";
  static const String routeLogo = "assets/images/RouteLogo.png";
  static const String screenshots1 = "assets/images/Screenshots1.png";
  static const String screenshots2 = "assets/images/Screenshots2.png";
  static const String screenshots3 = "assets/images/Screenshots3.png";
  static const String watchNow = "assets/images/WatchNow.png";
  //########################################################################
  static const String profile01 = "assets/images/ProfileAvatars/Profile01.png";
  static const String profile02 = "assets/images/ProfileAvatars/Profile02.png";
  static const String profile03 = "assets/images/ProfileAvatars/Profile03.png";
  static const String profile04 = "assets/images/ProfileAvatars/Profile04.png";
  static const String profile05 = "assets/images/ProfileAvatars/Profile05.png";
  static const String profile06 = "assets/images/ProfileAvatars/Profile06.png";
  static const String profile07 = "assets/images/ProfileAvatars/Profile07.png";
  static const String profile08 = "assets/images/ProfileAvatars/Profile08.png";
  static const String profile09 = "assets/images/ProfileAvatars/Profile09.png";
  //########################################################################
  static const List<String> profileAvatars = [
    profile01, profile02, profile03,
    profile04, profile05, profile06,
    profile07, profile08, profile09,
  ];

  /// Maps the 1-based vatar index stored on UserModel/Firestore to its asset path.
  static String avatarByIndex(int index) {
    if (index < 1 || index > profileAvatars.length) return profile01;
    return profileAvatars[index - 1];
  }

  static int indexByAvatar(String avatarPath) {
    final index = profileAvatars.indexOf(avatarPath);

    if (index == -1) return 1;

    return index + 1;
  }
  //########################################################################
  static const String moviesPosters = "assets/images/OnBoarding/MoviesPosters.png";
  static const String onBoarding1 = "assets/images/OnBoarding/OnBoarding1.png";
  static const String onBoarding2 = "assets/images/OnBoarding/OnBoarding2.png";
  static const String onBoarding3 = "assets/images/OnBoarding/OnBoarding3.png";
  static const String onBoarding4 = "assets/images/OnBoarding/OnBoarding4.png";
  static const String onBoarding5 = "assets/images/OnBoarding/OnBoarding5.png";
  //########################################################################
  static const String moviePoster1 = "assets/images/MoviePosters/MoviePoster1.png";
  static const String moviePoster2 = "assets/images/MoviePosters/MoviePoster2.png";
  static const String moviePoster3 = "assets/images/MoviePosters/MoviePoster3.png";
  static const String moviePoster4 = "assets/images/MoviePosters/MoviePoster4.png";
  static const String moviePoster5 = "assets/images/MoviePosters/MoviePoster5.png";
  static const String moviePoster6 = "assets/images/MoviePosters/MoviePoster6.png";
  //################################################################################
}




class AppIcons{
  static const String arrowBack = "assets/icons/ArrowBack.png";
  static const String back = "assets/icons/Back.png";
  static const String bookmark = "assets/icons/Bookmark.png";
  static const String eg = "assets/icons/EG.png";
  static const String email = "assets/icons/Email.png";
  static const String exit = "assets/icons/Exit.png";
  static const String explore = "assets/icons/Explore.png";
  static const String exploreSolid = "assets/icons/ExploreSolid.png";
  static const String favourite = "assets/icons/Favourite.png";
  static const String google = "assets/icons/Google.png";
  static const String hide = "assets/icons/Hide.png";
  static const String password = "assets/icons/Hide.png";
  static const String history = "assets/icons/History.png";
  static const String home = "assets/icons/Home.png";
  static const String homeSolid = "assets/icons/HomeSolid.png";
  static const String lr = "assets/icons/LR.png";
  static const String name = "assets/icons/Name.png";
  static const String person = "assets/icons/Person.png";
  static const String phone = "assets/icons/Phone.png";
  static const String profile = "assets/icons/Profile.png";
  static const String profileSolid = "assets/icons/ProfileSolid.png";
  static const String search = "assets/icons/Search.png";
  static const String searchSolid = "assets/icons/SearchSolid.png";
  static const String star = "assets/icons/Star.png";
  static const String watch = "assets/icons/Watch.png";
  static const String watchList = "assets/icons/WatchList.png";
  static const String imagePlaceholder = "assets/images/image placeholder.jpg";

}
