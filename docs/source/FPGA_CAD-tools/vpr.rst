VPR models
==========

To generate the necessary materials to program using VPR, run ``$FAB_ROOT/fabric_generator/fabric_gen.py`` with the -genVPRModel flag followed by the location of your custom information XML file (an description an example of which can be found below). In the ``$FAB_ROOT/fabric_generator/vproutput`` directory, two files will be created: ``architecture.xml`` and ``routing_resources.xml``. 

architecture.xml contains a description of the various tiles, ports and BELs - everything in the architecture except for the routing resources. 

routing_resources.xml contains the specifications of these routing resources, in the form of a graph within which the nodes are routing wires and ports, and the edges are the switch matrix interconnects that connect these resources.

Adding custom XML
-----------------

The auto-generated XML that FABulous creates for different BELs cannot cover all cases - for example, a BEL might depend on special functionality within VPR or require use of standard BLIF primitives, making it impractical to use as a blackbox. In this case, custom XML can be inserted when certain BELs are encountered, using the `VTR Architecture Description language <https://vtr-docs.readthedocs.io/en/latest/arch/index.html>`_. This is handled by the provision of a custom XML file, which can contain custom XML that will be directly inserted into the architecture file to describe certain logical elements. This is currently a mandatory argument, as at time of writing VPR algorithms rely on BLIF primitive IO pads that FABulous is not able to reliably derive. For each BEL in the architecture (equivalent to a second-level ``pb_type``), custom XML for the ``pb_type``, ``model`` and interconnect specification can be provided.

The custom XML file should open and close with ``<custom_xml_spec>`` and ``</custom_xml_spec>`` tags. For each BEL that requires custom XML, a ``<bel_info name="string"> content <\bel_info>`` tag should be added, where ``name`` is the name of the BEL as specified by the name of the HDL file. The children of this tag then contain the XML to be inserted. Each of these child tags should occur only once, and the contents of the tags should be as follows:

**<bel_pb> content <\bel_pb>**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This tag should contain the exact XML that should be inserted to define the second-level ``pb_type`` that represents this bel, including the ``<pb_type>`` tag itself. This should represent only one instance of the BEL (i.e. ``num_pb`` should be 1) as different instances are now represented by FABulous as individual subtiles, each of which has the ``pb_type`` as its equivalent site. Your XML will be automatically inserted inside a top-level wrapper ``pb_type``, and all inputs/outputs will be routed through into your description - therefore, it is required that your custom ``pb_type`` has at least the inputs and outputs described in your HDL model.

**<bel_model> content <\bel_model>**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This tag should contain the exact XML that should be inserted to define any models that you require for your description, including the ``model`` tag - a model will typically represent a leaf ``pb_type`` - i.e. a ``pb_type`` tag with no children. This tag does not need to be provided if you are only using BLIF standard primitives such as ``.names``, ``.input`` and ``.output``, as these models are available by default and do not need to be specified. If the tag is not provided or is left empty, no model XML will be generated at all for the BEL.

**<bel_interconnect> content <\bel_interconnect>**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This tag allows the user to insert custom interconnect into the top level wrapper ``pb_type``, a wrapper around your BEL's instantiation. Note that unlike the other tags, the ``interconnect`` tag should **NOT** be included within this tag - the contents will be inserted directly into an existing ``interconnect`` tag so that automatically generated interconnects can still be used. For the majority of use-cases custom interconnect will most likely be unnecessary, but it may be useful if you want to affect routing from the wrapper to a primitive e.g. by duplicating an input to feed it into two ports without having to create another layer of ``pb_type`` tags.

Example Custom XML File
-----------------------
The following is the custom XML file used for the generic architecture.

.. code-block:: xml

     <custom_xml_spec>
          <bel_info name="LUT4c_frame_config">
               <bel_pb>
                    <pb_type name="LUT4c_frame_config" num_pb="1">
                         <pb_type name="lut4" blif_model=".names" num_pb="1" class="lut">
                              <input name="in" num_pins="4" port_class="lut_in"/>
                              <output name="out" num_pins="1" port_class="lut_out"/>
                              <delay_matrix type="max" in_port="lut4.in" out_port="lut4.out">
                                   2.690e-10
                                   2.690e-10
                                   2.690e-10
                                   2.690e-10
                              </delay_matrix>
                              <metadata>
                                   <meta name="fasm_type">LUT</meta>
                                   <meta name="fasm_lut">
                                   INIT[15:0]
                                   </meta>
                              </metadata>
                         </pb_type>
                         <pb_type name="ff" blif_model=".latch" class="flipflop" num_pb="1">
                              <input name="D" num_pins="1" port_class="D"/>
                              <output name="Q" num_pins="1" port_class="Q"/>
                              <clock name="clk" num_pins="1" port_class="clock"/>
                              <T_setup value="2.448e-10" port="ff.D" clock="clk"/>
                              <T_clock_to_Q max="7.732e-11" port="ff.Q" clock="clk"/>
                         </pb_type>
                         <input name="I0" num_pins="1"/>
                         <input name="I1" num_pins="1"/>
                         <input name="I2" num_pins="1"/>
                         <input name="I3" num_pins="1"/>
                         <input name="Ci" num_pins="1"/>
                         <clock name="UserCLK" num_pins="1"/>
                         <output name="O" num_pins="1"/>
                         <output name="Co" num_pins="1"/>
                         <input name="SR" num_pins="1"/>
                         <input name="EN" num_pins="1"/>
                         <interconnect>
                              <direct name="I0_to_LUT_in" input="LUT4c_frame_config.I0" output="lut4.in[0]"/>
                              <direct name="I1_to_LUT_in" input="LUT4c_frame_config.I1" output="lut4.in[1]"/>
                              <direct name="I2_to_LUT_in" input="LUT4c_frame_config.I2" output="lut4.in[2]"/>
                              <direct name="I3_to_LUT_in" input="LUT4c_frame_config.I3" output="lut4.in[3]"/>
                              <direct name="LUT_out_to_ff" input="lut4.out" output="ff.D">
                                   <pack_pattern name="lut_with_ff" in_port="lut4.out" out_port="ff.D"/>
                              </direct>
                              <direct name="clock_pb_to_lut" input="LUT4c_frame_config.UserCLK" output="ff.clk"/>
                              <mux name="lut4c_out_mux" input="ff.Q lut4.out" output="LUT4c_frame_config.O">
                                   <delay_constant max="25e-12" in_port="lut4.out" out_port="LUT4c_frame_config.O"/>
                                   <delay_constant max="45e-12" in_port="ff.Q" out_port="LUT4c_frame_config.O"/>
                                   <metadata>
                                        <meta name="fasm_mux">
                                        ff.Q: FF
                                        lut4.out: NULL
                                        </meta>
                                   </metadata>
                              </mux>
                         </interconnect>
                    </pb_type>
               </bel_pb>
          </bel_info>
          <bel_info name="IO_1_bidirectional_frame_config_pass">
               <bel_pb>
                    <pb_type name="IO_1_bidirectional_frame_config_pass" num_pb="1">
                         <mode name="pad_is_input">
                              <pb_type name="W_input" blif_model=".input" num_pb="1">
                                   <output name="inpad" num_pins="1"/>
                              </pb_type>
                              <interconnect>
                                   <direct name="input_interconnect" input="W_input.inpad" output="IO_1_bidirectional_frame_config_pass.O"/>
                              </interconnect>
                         </mode>
                         <mode name="pad_is_output">
                              <pb_type name="W_output" blif_model=".output" num_pb="1">
                                   <input name="outpad" num_pins="1"/>
                              </pb_type>
                              <interconnect>
                                   <direct name="output_interconnect" input="IO_1_bidirectional_frame_config_pass.I" output="W_output.outpad"/>
                              </interconnect>
                         </mode>
                         <input name="UserCLK" num_pins="1"/>
                         <input name="I" num_pins="1"/>
                         <input name="T" num_pins="1"/>
                         <output name="O" num_pins="1"/>
                         <output name="Q" num_pins="1"/>
                    </pb_type>
               </bel_pb>
          </bel_info>
     </custom_xml_spec>

Notes for developers
--------------------

The ptc number provided for each node in the routing resource (RR) graph represents the pin, track or class of the node. With SOURCE, SINK, IPIN and OPIN nodes, this is the ptc of the appropriate pin in the block type definition, however with CHANY and CHANX nodes it is more arbitrary. Here, each wire's ptc number should be different from any wire it overlaps with **anywhere along its length**. Previously, every wire had a separate PTC number, but this was recently updated so that no horizontal wire has the same number as any vertical wire, no two horizontal wires in the same row share a number, and no two vertical wires in the same column share a number. More information on the meaning of the PTC number can be found in `this Google Group discussion <https://groups.google.com/g/vtr-users/c/ZFXPn-W3SxA/m/ROkfD2oEAQAJ>`_.

Although no meaningful routing connections are specified in the architecture.xml file, it is important that all pins do not have an Fc value of 0. This is because VPR uses the Fc value to gauge how well connected to the fabric a pin is, and so will not be able to find any routing candidates with 0 Fc pins. Currently FABulous is set up with a default fractional Fc of 1 such that all pins are connected to the fabric and are viable candidates.

Due to the techmapping complexity, the multiplexers in the LUT4AB tiles are currently ignored and it is assumed each LUT is routed to a separate output - at the time of writing, the same assumption is made for the nextpnr model.

