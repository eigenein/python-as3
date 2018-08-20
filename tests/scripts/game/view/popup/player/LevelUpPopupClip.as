package game.view.popup.player
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class LevelUpPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_level:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_energy:ClipLabel;
      
      public var tf_label_energy:ClipLabel;
      
      public var tf_label_energy_reward:ClipLabel;
      
      public var tf_label_hero_lvl:ClipLabel;
      
      public var tf_max_energy:ClipLabel;
      
      public var tf_max_energy_before:ClipLabel;
      
      public var tf_max_hero_lvl:ClipLabel;
      
      public var tf_max_hero_lvl_before:ClipLabel;
      
      public var mechanics_group:LevelUpPopupMechanicsGroupClip;
      
      public var icon_energy0:ClipSprite;
      
      public var layout_energy:ClipLayout;
      
      public var okButton:ClipButtonLabeled;
      
      public var rays_inst0:GuiAnimation;
      
      public var rays_inst1:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public function LevelUpPopupClip()
      {
         tf_level = new ClipLabel();
         tf_header = new ClipLabel();
         tf_energy = new ClipLabel(true);
         tf_label_energy = new ClipLabel();
         tf_label_energy_reward = new ClipLabel(true);
         tf_label_hero_lvl = new ClipLabel();
         tf_max_energy = new ClipLabel();
         tf_max_energy_before = new ClipLabel();
         tf_max_hero_lvl = new ClipLabel();
         tf_max_hero_lvl_before = new ClipLabel();
         mechanics_group = new LevelUpPopupMechanicsGroupClip();
         icon_energy0 = new ClipSprite();
         layout_energy = ClipLayout.horizontalMiddleCentered(4,tf_label_energy_reward,icon_energy0,tf_energy);
         rays_inst0 = new GuiAnimation();
         rays_inst1 = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         super();
      }
   }
}
