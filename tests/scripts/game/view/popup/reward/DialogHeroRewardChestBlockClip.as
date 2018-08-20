package game.view.popup.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class DialogHeroRewardChestBlockClip extends GuiClipNestedContainer
   {
       
      
      public var button:ClipButtonLabeled;
      
      public var tf_chest_label:ClipLabel;
      
      public var tf_chest_label_layout:ClipLayout;
      
      public var ChestBronzeMediumIcon_inst0:ClipSprite;
      
      public var bg:GuiClipScale9Image;
      
      public function DialogHeroRewardChestBlockClip()
      {
         button = new ClipButtonLabeled();
         tf_chest_label = new ClipLabel();
         tf_chest_label_layout = ClipLayout.horizontalMiddleCentered(0,tf_chest_label);
         ChestBronzeMediumIcon_inst0 = new ClipSprite();
         bg = new GuiClipScale9Image();
         super();
      }
   }
}
