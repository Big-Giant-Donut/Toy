# Down with enums!

This is a toy project that demonstrates how to create a SwiftUI project without using enums.  We implement the same toy project twice.  The first time, we use the "natural" enum.  The second time, we implement each icon as a separate struct, but implement a protocol that makes it trivial to access the SwiftUI View for each icon when needed.

There is some explanation of the differences in the code.

To run the Toy, compile and execute the Toy target.  The checkbox at the top selects which method to use for rendering.  If not checked, enums are used.  If checked, a simpler, alternative method that uses a protocol is used instead.  The visual appearance of the two methods should be identical.

The three buttons on the left select which icon to display on the right.  Each icon has it's own View, and displays slightly different information.  The Views for the two methods are almost identical.  The main difference is that the second method does not require any structural changes when adding an additional type of icon, while the first method requires changes in two different places.
