import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.newsTitle,
    required this.newPicture,
    this.userPicture,
    this.userName,
    this.newTime,
    required this.onTap,
  });

  final String newsTitle;
  final String newPicture;
  final String? userPicture;
  final String? userName;
  final String? newTime;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: newPicture.isNotEmpty
                  ? Image.network(
                      newPicture,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 115,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/1.jpg',
                          fit: BoxFit.cover,
                          height: 120,
                          width: 115,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/1.jpg',
                      fit: BoxFit.cover,
                      height: 120,
                      width: 115,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      newsTitle,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (userPicture != null || userName != null)
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: userPicture != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userPicture!),
                            )
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/2.jpg'),
                            ),
                      subtitle: Text(
                        newTime ?? "8 Aug, 2024",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      title: Text(
                        userName ?? "Haider Ali",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
