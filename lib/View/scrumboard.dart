import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrumboard/View/home_screen.dart';
import 'package:scrumboard/Provider/provider_scrumboard.dart';
import '../Provider/logon_provider.dart';

class Scrumboard extends StatefulWidget {
  const Scrumboard({Key? key}) : super(key: key);

  @override
  _ScrumboardState createState() => _ScrumboardState();
}

class _ScrumboardState extends State<Scrumboard> {
  final LogonProvider _logonProvider = LogonProvider();
  bool isLoggedIn = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _showLogIndDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Password',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String username = _usernameController.text;
                          String password = _passwordController.text;

                          try {
                            final token =
                                _logonProvider.login(username, password);
                            setState(() {
                              isLoggedIn = true;
                            });
                            print('$token');
                            Navigator.pop(context);
                          } catch (e) {
                            print('Login failed: $e');
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scrumboard'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              if (!isLoggedIn)
                ListTile(
                  title: const Text('Log ind'),
                  onTap: () {
                    _showLogIndDialog(context);
                  },
                ),
              if (isLoggedIn)
                ListTile(
                  title: const Text('Log out'),
                  onTap: () {
                    setState(() {
                      isLoggedIn = false;
                    });
                  },
                ),
              if (isLoggedIn)
                ListTile(
                  title: const Text('Vis opslagstavlen'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
            ],
          ),
        ),
        body: ScrumBoardView(),
      ),
    );
  }
}

class ScrumBoardView extends StatefulWidget {
  ScrumBoardView({Key? key}) : super(key: key);

  @override
  _ScrumBoardViewState createState() {
    return _createScrumBoardViewState();
  }

  _ScrumBoardViewState _createScrumBoardViewState() {
    return _ScrumBoardViewState();
  }
}

class _ScrumBoardViewState extends State<ScrumBoardView> {


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScrumboardProvider>(); // Access provider
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: ReorderableListView(
              children: [
                for (final tile in provider.productionlist)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      left: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                    ),
                    key: ValueKey(tile),
                    title: Text(tile.title),
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex > 0 && newIndex > 0) {
                  updateProductionTiles(oldIndex, newIndex, provider);
                }
              },
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: [
                for (final tile in provider.storylist)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                    ),
                    key: ValueKey(tile),
                    title: Text(tile.title),
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex > 0 && newIndex > 0) {
                  updateStoryTiles(oldIndex, newIndex, provider);
                }
              },
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: [
                for (final tile in provider.toDolist)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                    ),
                    key: ValueKey(tile),
                    title: Text(tile.title),
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex > 0 && newIndex > 0) {
                  updateToDoTiles(oldIndex, newIndex, provider);
                }
              },
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: [
                for (final tile in provider.doinglist)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                    ),
                    key: ValueKey(tile),
                    title: Text(tile.title),
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex > 0 && newIndex > 0) {
                  updateDoingTiles(oldIndex, newIndex, provider);
                }
              },
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: [
                for (final tile in provider.donelist)
                  ListTile(
                    shape: const Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                    ),
                    key: ValueKey(tile),
                    title: Text(tile.title),
                  )
              ],
              onReorder: (oldIndex, newIndex) {
                if (oldIndex > 0 && newIndex > 0) {
                  updateDoneTiles(oldIndex, newIndex, provider);
                }
              },
            ),
          ),
        ],
      ),

       // Floating action buttons for adding images and resetting
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () { _showCreateCardDialog(context); },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
    );
  }

  void updateProductionTiles(int oldIndex, int newIndex, provider) {
    setState(() {
      final tile = provider.productionlist.removeAt(oldIndex);
      provider.productionlist.insert(newIndex, tile);
    });
  }

  void updateStoryTiles(int oldIndex, int newIndex, provider) {
    setState(() {
      final tile = provider.storylist.removeAt(oldIndex);
      provider.storylist.insert(newIndex, tile);
    });
  }

  void updateToDoTiles(int oldIndex, int newIndex, provider) {
    setState(() {
      final tile = provider.toDolist.removeAt(oldIndex);
      provider.toDolist.insert(newIndex, tile);
    });
  }

  void updateDoingTiles(int oldIndex, int newIndex, provider) {
    setState(() {
      final tile = provider.doinglist.removeAt(oldIndex);
      provider.doinglist.insert(newIndex, tile);
    });
  }

  void updateDoneTiles(int oldIndex, int newIndex, provider) {
    setState(() {
      final tile = provider.donelist.removeAt(oldIndex);
      provider.donelist.insert(newIndex, tile);
    });
  }

    // dialog for adding cards
  Future<void> _showCreateCardDialog(
      BuildContext context, ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              ),     
            ],
          ),
        );
      },
    );
  }
}
