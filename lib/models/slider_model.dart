class SliderModel {
  String imagePath;
  String title;
  String description;

  SliderModel({this.imagePath, this.title, this.description});

  void setImageAssetPath(String getImageAssetPath) {
    imagePath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    description = getDesc;
  }

  String getImageAssetPath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return description;
  }

  List<SliderModel> getSlides() {
    List<SliderModel> slides = new List<SliderModel>();
    SliderModel sliderModel = new SliderModel();

    //1
    sliderModel.setDesc(
        "Discover Restaurants offering the best fast food food near you on Foodwa");
    sliderModel.setTitle("Search");
    sliderModel.setImageAssetPath("asset/images/illustration.png");
    slides.add(sliderModel);

    sliderModel = new SliderModel();

    //2
    sliderModel.setDesc(
        "Our veggie plan is filled with delicious seasonal vegetables, whole grains, beautiful cheeses and vegetarian proteins");
    sliderModel.setTitle("Order");
    sliderModel.setImageAssetPath("asset/images/illustration2.png");
    slides.add(sliderModel);

    sliderModel = new SliderModel();

    //3
    sliderModel.setDesc(
        "Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
    sliderModel.setTitle("Eat");
    sliderModel.setImageAssetPath("asset/images/illustration3.png");
    slides.add(sliderModel);

    sliderModel = new SliderModel();

    //4
    sliderModel.setDesc(
        "Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
    sliderModel.setTitle("Eat");
    sliderModel.setImageAssetPath("asset/images/illustration3.png");
    slides.add(sliderModel);

    return slides;
  }
}
