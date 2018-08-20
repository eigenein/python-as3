package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanFrgmentFindGroup1Clip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_fragments_find_1:ClipLabel;
      
      public var button_fragment_find_1:ClipButtonLabeled;
      
      public var layout_group_1:ClipLayout;
      
      public function TitanFrgmentFindGroup1Clip()
      {
         tf_label_fragments_find_1 = new ClipLabel();
         button_fragment_find_1 = new ClipButtonLabeled();
         layout_group_1 = ClipLayout.horizontalMiddleCentered(0,tf_label_fragments_find_1);
         super();
      }
   }
}
