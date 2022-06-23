VPR models
==========

To generate the necessary materials to program using VPR, run ``$FAB_ROOT/fabric_generator/fabric_gen.py`` with the -genVPRModel flag. In the ``$FAB_ROOT/fabric_generator/vproutput`` directory, two files will be created - ``architecture.xml`` and ``routing_resources.xml``. 

architecture.xml contains a description of the various tiles, ports and BELs - everything in the architecture except for the routing resources. 

routing_resources.xml contains the specifications of these routing resources, in the form of a graph within which the nodes are routing wires and ports, and the edges are the switch matrix interconnects that connect these resources.

Adding custom XML
-----------------

The auto-generated XML that FABulous creates for different BELs cannot cover all cases - for example, a BEL might depend on special functionality within VPR or require use of standard BLIF primitives, making it impractical to use as a blackbox. In this case, custom XML can be inserted when certain BELs are encountered, using the `VTR Architecture Description language <https://vtr-docs.readthedocs.io/en/latest/arch/index.html>`_. To do this, store the corresponding XML for the pb\_type, including the opening and closing tags, in the structure specialBelDict, with the key being the name of the BEL that should be replaced. This is particularly flexible as the XML doesn't have to be inserted directly into the code - extra code can be added to generate this XML if desired. In order to generate FASM, and therefore a bitstream, with your architecture, it may be necessary to add FASM prefixes if your BEL has more than one instance. This allows the bitstream generator to understand which BEL a certain feature is being enabled/set on. FABulous handles the actual prefixes itself, but the metadata tag itself must be provided by the user in case there is other metadata to be supplied. Where you wish to insert the metadata, simply write:

.. code-block:: xml

        <metadata>
             <meta name="fasm_prefix"> {fasm_prefix_list} </meta>
        </metadata>

and add any other desired metadata within the metadata tag. When producing the architecture specification, FABulous will automatically replace ``fasm_prefix_list`` with the necessary prefixes to meet the bitstream specification, using the ``num_pb`` value within your XML to decide how many prefixes are necessary.

If a BEL is found in the specialBelDict, there are two other features that can be used to ensure everything fits together as desired. If this ``pb_type`` also requires custom model XML, this can be inserted into specialModelDict, once again with the name of the BEL as the key and including the model tag. Only model XML provided here will be added - the default is not to generate anything for special BELs. This may be useful if the BEL you are representing does not use a standard BLIF primitive, and still requires a matching model. 

Similarly, there is a specialInterconnectDict, which can be used to insert special interconnect XML into the interconnect tag of the top-level ``pb_type`` that houses the BEL. Note that in this case, you should not include the interconnect tag in your XML, as it will be inserted within an interconnect tag. This may be useful, for example, when generating custom XML for BELs that require a clock input, so that the clock signal can be routed into the BEL. The key in the dict should be the name of the BEL that the corresponding custom ``pb_type`` XML is for. Please note that the clock is NOT automatically routed from the top ``pb_type``'s UserCLK port to the clock port of the BEL, and this must be done with custom interconnect XML - this is to provide more flexibility with clock interconnection e.g. different port names or multiple connections.


Notes for developers
--------------------

The ptc number provided for each node in the routing resource (RR) graph represents the pin, track or class of the node. With SOURCE, SINK, IPIN and OPIN nodes, this is the ptc of the appropriate pin in the block type definition, however with CHANY and CHANX nodes it is more arbitrary. Here, each wire's ptc number should be different from any wire it overlaps with **anywhere along its length**. Previously, every wire had a separate PTC number, but this was recently updated so that no horizontal wire has the same number as any vertical wire, no two horizontal wires in the same row share a number, and no two vertical wires in the same column share a number. More information on the meaning of the PTC number can be found in `this Google Group discussion <https://groups.google.com/g/vtr-users/c/ZFXPn-W3SxA/m/ROkfD2oEAQAJ>`_.

Although no meaningful routing connections are specified in the architecture.xml file, it is important that all pins do not have an Fc value of 0. This is because VPR uses the Fc value to gauge how well connected to the fabric a pin is, and so will not be able to find any routing candidates with 0 Fc pins. Currently FABulous is set up with a default fractional Fc of 1 such that all pins are connected to the fabric and are viable candidates.

Due to the techmapping complexity, the multiplexers in the LUT4AB tiles are currently ignored and it is assumed each LUT is routed to a separate output - at the time of writing, the same assumption is made for the nextpnr model.

