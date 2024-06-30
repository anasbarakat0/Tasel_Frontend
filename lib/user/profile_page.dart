import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/bloc/profile_info_bloc.dart';
import 'package:tasel_frontend/user/profile_page_update.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  final TokenModel userId;
  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String id;
  late String name;
  late int phone;
  late String email;
  late String address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoBloc(),
      child: Builder(builder: (context) {
        context
            .read<ProfileInfoBloc>()
            .add(ShowProfileInfo(userId: widget.userId));
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile Page',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfilePage(
                    tokenId: widget.userId,
                    id: id,
                    name: name,
                    phone: phone,
                    address: address,
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
          body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoInitial) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Connecting ...',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 100,
                        child: LinearProgressIndicator(),
                      ),
                    ],
                  ),
                );
              } else if (state is LoadingProfileInfo) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorProfileInfo) {
                return Center(child: Text(state.message));
              } else if (state is SuccessProfileInfo) {
                id = state.userInfo.id;
                name = state.userInfo.name;
                address = state.userInfo.address;
                email = state.userInfo.email;
                phone = state.userInfo.phone;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/tasel.png') as ImageProvider,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.userInfo.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInfoTile(
                            label: 'Phone',
                            value: state.userInfo.phone.toString(),
                            icon: Icons.phone,
                          ),
                          UserInfoTile(
                            label: 'Email',
                            value: state.userInfo.email,
                            icon: Icons.email,
                          ),
                          UserInfoTile(
                            label: 'Address',
                            value: state.userInfo.address,
                            icon: Icons.home,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: LinearProgressIndicator());
              }
            },
          ),
        );
      }),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      colors: [AppColors.yellow, AppColors.darkYellow],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final Paint paint = Paint()..shader = gradient.createShader(rect);

    final Path path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height * 2, size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class UserInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const UserInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.grey,
      shadowColor: Colors.black54,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.yellow),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            color: Colors.grey[300],
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
