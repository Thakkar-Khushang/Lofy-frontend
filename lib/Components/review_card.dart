import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {Key? key,
      required this.review,
      required this.rating,
      required this.user})
      : super(key: key);
  final review;
  final rating;
  final user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 17.0, top: 8, right: 17, bottom: 7),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 60),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user ?? "Anonymous User",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Text(
                          review,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          "$rating/5",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
