import 'package:firstproject/new/Note/routes/route_generator.dart';
import 'package:firstproject/new/Note/screens/notes_edit.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';

import '../models/notes_database.dart';
import '../theme/note_colors.dart';

void main() async {
  runApp(const AppEntry());
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: GenerateAllRoutes.generateRoute,
    );
  }
}

const c0 = 0xFF000000,
    c1 = 0xFFFDFFFC,
    c2 = 0xFFFF595E,
    c3 = 0xFF374B4A,
    c4 = 0xFF00B1CC,
    c5 = 0xFFFFD65C,
    c6 = 0xFFB9CACA,
    c7 = 0x80374B4A,
    c8 = 0x3300B1CC,
    c9 = 0xCCFF595E;

/*
* Read all notes stored in database and sort them based on name
*/
Future<List<Map<String, dynamic>>> readDatabase() async {
  try {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    List<Map> notesList = await notesDb.getAllNotes();
    //await notesDb.deleteAllNotes();
    await notesDb.closeDatabase();
    List<Map<String, dynamic>> notesData =
        List<Map<String, dynamic>>.from(notesList);
    notesData.sort((a, b) => (a['title']).compareTo(b['title']));
    return notesData;
  } catch (e) {
    return [{}];
  }
}

// Home Screen
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  // Read Database and get Notes
  late List<Map<String, dynamic>> notesData;
  List<int> selectedNoteIds = [];

  // Render the screen and update changes
  void afterNavigatorPop() {
    setState(() {});
  }

  // Long Press handler to display bottom bar
  void handleNoteListLongPress(int id) {
    setState(() {
      if (selectedNoteIds.contains(id) == false) {
        selectedNoteIds.add(id);
      }
    });
  }

  // Remove selection after long press
  void handleNoteListTapAfterSelect(int id) {
    setState(() {
      if (selectedNoteIds.contains(id) == true) {
        selectedNoteIds.remove(id);
      }
    });
  }

  // Delete Note/Notes
  void handleDelete() async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      for (int id in selectedNoteIds) {
        int result = await notesDb.deleteNote(id);
      }
      await notesDb.closeDatabase();
    } catch (e) {
      print('delete catch error is: $e');
    } finally {
      setState(() {
        selectedNoteIds = [];
      });
    }
  }

  // Share Note/Notes
  void handleShare() async {
    String content = '';
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      for (int id in selectedNoteIds) {
        dynamic notes = await notesDb.getNotes(id);
        if (notes != null) {
          content = '${content + notes['title'] + '\n' + notes['content']}\n\n';
        }
      }
      await notesDb.closeDatabase();
    } catch (e) {
      print('share note catch error is: $e');
    } finally {
      setState(() {
        selectedNoteIds = [];
      });
    }
    await Share.share(content.trim(), subject: content.split('\n')[0]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.7),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(c0),
        // brightness: Brightness.dark,
        leading: (selectedNoteIds.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    selectedNoteIds = [];
                  });
                },
                icon: const Icon(
                  Icons.close,
                  color: Color(c1),
                ),
              )
            :
            //AppBarLeading()
            Container()),
        title: Text(
          (selectedNoteIds.isNotEmpty
              ? ('Selected ${selectedNoteIds.length}/${notesData.length}')
              : 'New Note'),
          style: const TextStyle(
            color: Color(c5),
          ),
        ),
        actions: [
          (selectedNoteIds.isEmpty
              ? Container()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      selectedNoteIds =
                          notesData.map((item) => item['id'] as int).toList();
                    });
                  },
                  icon: const Icon(
                    Icons.done_all,
                    color: Color(c5),
                  ),
                ))
        ],
      ),

      /*
			//Drawer
			drawer: Drawer(
				child: DrawerList(),
			),
			*/

      //Floating Button
      floatingActionButton: (selectedNoteIds.isEmpty
          ? FloatingActionButton(
              tooltip: 'New Notes',
              backgroundColor: const Color(c4),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/notes_edit',
                  arguments: [
                    'new',
                    [{}],
                  ],
                ).then((dynamic value) {
                  afterNavigatorPop();
                });
                return;
              },
              child: const Icon(
                Icons.add,
                color: Color(c5),
              ),
            )
          : null),
      body: FutureBuilder(
        future: readDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            notesData = snapshot.data!;
            return Stack(
              children: <Widget>[
                // Display Notes
                AllNoteLists(
                  snapshot.data,
                  selectedNoteIds,
                  afterNavigatorPop,
                  handleNoteListLongPress,
                  handleNoteListTapAfterSelect,
                ),
                // Bottom Action Bar when Long Pressed
                (selectedNoteIds.isNotEmpty
                    ? BottomActionBar(
                        handleDelete: handleDelete, handleShare: handleShare)
                    : Container()),
              ],
            );
          } else if (snapshot.hasError) {
            // Handle the error case
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff000000),
              ),
            );
          }
        },
      ),
    );
  }
}

// Display all notes
class AllNoteLists extends StatelessWidget {
  final data;
  final selectedNoteIds;
  final afterNavigatorPop;
  final handleNoteListLongPress;
  final handleNoteListTapAfterSelect;

  AllNoteLists(
    this.data,
    this.selectedNoteIds,
    this.afterNavigatorPop,
    this.handleNoteListLongPress,
    this.handleNoteListTapAfterSelect,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          dynamic item = data[index];
          return DisplayNotes(
            item,
            selectedNoteIds,
            (selectedNoteIds.contains(item['id']) == false ? false : true),
            afterNavigatorPop,
            handleNoteListLongPress,
            handleNoteListTapAfterSelect,
          );
        });
  }
}

// A Note view showing title, first line of note and color
class DisplayNotes extends StatelessWidget {
  final notesData;
  final selectedNoteIds;
  final selectedNote;
  final callAfterNavigatorPop;
  final handleNoteListLongPress;
  final handleNoteListTapAfterSelect;

  DisplayNotes(
    this.notesData,
    this.selectedNoteIds,
    this.selectedNote,
    this.callAfterNavigatorPop,
    this.handleNoteListLongPress,
    this.handleNoteListTapAfterSelect,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 10,
        color: (selectedNote == false ? const Color(c1) : const Color(c8)),
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          onTap: () {
            if (selectedNote == false) {
              if (selectedNoteIds.length == 0) {
                Navigator.pushNamed(
                  context,
                  '/notes_edit',
                  arguments: [
                    'update',
                    notesData,
                  ],
                ).then((dynamic value) {
                  callAfterNavigatorPop();
                });
                return;
              } else {
                handleNoteListLongPress(notesData['id']);
              }
            } else {
              handleNoteListTapAfterSelect(notesData['id']);
            }
          },
          onLongPress: () {
            handleNoteListLongPress(notesData['id']);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (selectedNote == false
                              ? Color(NoteColors[notesData['noteColor']]!['b']!)
                              : const Color(c9)),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: (selectedNote == false
                              ? Text(
                                  notesData['title'][0],
                                  style: const TextStyle(
                                    color: Color(c1),
                                    fontSize: 21,
                                  ),
                                )
                              : const Icon(
                                  Icons.check,
                                  color: Color(c1),
                                  size: 21,
                                )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        notesData['title'] ?? "",
                        style: const TextStyle(
                          color: Color(c3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Text(
                        notesData['content'] != null
                            ? notesData['content'].split('\n')[0]
                            : "",
                        style: const TextStyle(
                          color: Color(c7),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BottomAction bar contais options like Delete, Share...
class BottomActionBar extends StatelessWidget {
  final VoidCallback handleDelete;
  final VoidCallback handleShare;

  const BottomActionBar({
    super.key,
    required this.handleDelete,
    required this.handleShare,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 2,
          color: const Color(c7),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Delete
                InkResponse(
                  onTap: () => handleDelete(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Color(c0),
                        semanticLabel: 'Delete',
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(c0),
                        ),
                      ),
                    ],
                  ),
                ),

                // Share
                InkResponse(
                  onTap: () => handleShare(),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.share,
                        color: Color(c0),
                        semanticLabel: 'Share',
                      ),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(c0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class AppBarLeading extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Builder(
			builder: (context) => IconButton(
				icon: const Icon(
					Icons.menu,
					color: const Color(c5),
				),
				tooltip: 'Menu',
				onPressed: () => Scaffold.of(context).openDrawer(),
			),
		);
	}
}

class DrawerList extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return ListView(
			children: ListTile.divideTiles(
				context: context,
				tiles: [
					Container(
						padding: EdgeInsets.symmetric(vertical: 16.0),
						child: Text(
							'Super Note',
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 29,
								color: Color(c4),
							),
						),
					),
					DrawerRow(Icons.share, 'Share App'),
					DrawerRow(Icons.settings, 'About'),
				],
			).toList(),
     );
	}
}

class DrawerRow extends StatelessWidget {
	final leadingIcon, title;

	DrawerRow(this.leadingIcon, this.title);

	@override
	Widget build(BuildContext context) {
		return ListTile(
			leading: Icon(
    		leadingIcon,
    		color: Color(c2),
    	),
      title: Text(
      	title,
      	style: TextStyle(
      		color: Color(c3),
      		fontSize: 19,
      	),
      ),
      trailing: Icon(
    		Icons.keyboard_arrow_right,
    		color: Color(c2),
    	),
    	dense: true,
    	onTap: () {},
    	onLongPress: () {},
		);
	}
}
*/
