package game.view.popup.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.titan_arena.popup.chest.TitanSpiritArtifactChestItemRenderer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class RewardSpiritPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var okButton:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var item:TitanSpiritArtifactChestItemRenderer;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var glob_inst0:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var rays_inst1:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public function RewardSpiritPopupClip()
      {
         tf_header = new ClipLabel();
         tf_name = new ClipLabel();
         tf_desc = new ClipLabel();
         okButton = new ClipButtonLabeled();
         button_close = new ClipButton();
         item = new TitanSpiritArtifactChestItemRenderer();
         animation_EpicRays_inst0 = new ClipSprite();
         glob_inst0 = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         rays_inst1 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         super();
      }
   }
}
