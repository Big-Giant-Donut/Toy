This is a toy project that demonstrates how to use The Composable Architecture to display different pieces of the model in the same area, where each different piece of the model has its own TCA implementation, and still allow the number of TCA implementations to be expanded at runtime, most likely by plugins.  It only requires that each model implement a few simple functions. It also demonstrates that changing the type of the state can easily cause a crash, and offers a modification to TCA to avoid the crash.

To run the Toy, compile and execute the Toy target.  It displays two almost identical Views, the first using the release TCA, and the second using a modified TCA.

The three buttons on the left of each View select which icon to display on the right.  Each icon has it's own View, and displays slightly different information.  Clicking button Two or Three in the left View will crash, because the release TCA does not properly handle the change in state.  Clicking any button on the right View works as expected.

Note that this is not all of the code required to implement TCA with protocol state.  Additional code is required to properly handle actions.  This is merely to demonstrate the need for an additional scope function.
