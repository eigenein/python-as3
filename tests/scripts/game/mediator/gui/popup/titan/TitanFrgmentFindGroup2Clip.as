package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanFrgmentFindGroup2Clip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_fragments_find_2:ClipLabel;
      
      public var button_fragment_find_2:ClipButtonLabeled;
      
      public var layout_group_2:ClipLayout;
      
      public function TitanFrgmentFindGroup2Clip()
      {
         tf_label_fragments_find_2 = new ClipLabel();
         button_fragment_find_2 = new ClipButtonLabeled();
         layout_group_2 = ClipLayout.horizontalMiddleCentered(0,tf_label_fragments_find_2);
         super();
      }
   }
}
