import '../../data/comment.dart';

final List<Comment> comments = [
  Comment(
    postTitle: "Example Post 1",
    communityTitle: "Example Community",
    time: "3h",
    votes: 10,
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ut lacus sed sapien ultrices fermentum.",
    username: "User1", // Add username
  ),
  Comment(
    postTitle: "Example Post 2",
    communityTitle: "Another Community",
    time: "1d",
    votes: 15,
    content: "Vestibulum nec nulla leo. Morbi maximus purus vel tincidunt ultricies.",
    username: "User2", // Add username
  ),
  // Add more comments here
  Comment(
    postTitle: "Example Post 3",
    communityTitle: "Yet Another Community",
    time: "2d",
    votes: 20,
    content: "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
    username: "User3", // Add username
  ),
  Comment(
    postTitle: "Example Post 4",
    communityTitle: "Community 4",
    time: "1w",
    votes: 8,
    content: "Nullam imperdiet justo ac dui cursus, vel accumsan urna commodo.",
    username: "User4", // Add username
  ),
  Comment(
    postTitle: "Example Post 5",
    communityTitle: "Community 5",
    time: "2w",
    votes: 12,
    content: "Donec ut nunc sed nisl tempor posuere. Mauris et accumsan elit.",
    username: "User5", // Add username
  ),
  // Add more comments as needed
];