class VideoCallModel {
  final String name;
  final String phone;
  final String? avatarAsset;
  final String? backgroundAsset;

  VideoCallModel({
    this.name = 'Cameron Williamson',
    this.phone = '(+44) 50 9285 3022',
    this.avatarAsset = 'assets/images/avatar.png',
    this.backgroundAsset = 'assets/images/videocall.png',
  });
}
