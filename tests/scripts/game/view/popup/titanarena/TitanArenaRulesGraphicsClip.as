package game.view.popup.titanarena
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaRulesGraphicsClip extends GuiClipNestedContainer
   {
       
      
      public var bg1:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public var bg3:GuiClipScale9Image;
      
      public var tf_1:ClipLabel;
      
      public var tf_2:ClipLabel;
      
      public var tf_3:ClipLabel;
      
      public function TitanArenaRulesGraphicsClip()
      {
         bg1 = new GuiClipScale9Image(new Rectangle(50,5,80,13));
         bg2 = new GuiClipScale9Image(new Rectangle(50,5,80,13));
         bg3 = new GuiClipScale9Image(new Rectangle(50,5,80,13));
         tf_1 = new ClipLabel();
         tf_2 = new ClipLabel();
         tf_3 = new ClipLabel();
         super();
      }
   }
}
