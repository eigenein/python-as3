package game.view.popup.reward
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class RewardHeroPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_hero_name:ClipLabel;
      
      public var okButton:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var fragment_container:GuiClipContainer;
      
      public var hero_container:GuiClipContainer;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var glob_inst0:ClipSprite;
      
      public var rays_inst0:GuiAnimation;
      
      public var rays_inst1:GuiAnimation;
      
      public var star_layout_container:ClipLayout;
      
      public var star_epic:GuiAnimation;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var chest_block:DialogHeroRewardChestBlockClip;
      
      public var layout_fragment_btns:ClipLayout;
      
      public var layout_captions:ClipLayout;
      
      public function RewardHeroPopupClip()
      {
         tf_caption = new ClipLabel();
         tf_header = new ClipLabel();
         tf_hero_name = new ClipLabel();
         okButton = new ClipButtonLabeled();
         button_close = new ClipButton();
         fragment_container = new GuiClipContainer();
         hero_container = new GuiClipContainer();
         animation_EpicRays_inst0 = new ClipSprite();
         glob_inst0 = new ClipSprite();
         rays_inst0 = new GuiAnimation();
         rays_inst1 = new GuiAnimation();
         star_layout_container = ClipLayout.horizontalCentered(1);
         star_epic = new GuiAnimation();
         ribbon_154_154_2_inst0 = new ClipSprite();
         chest_block = new DialogHeroRewardChestBlockClip();
         layout_fragment_btns = ClipLayout.verticalMiddleCenter(4,fragment_container,okButton,chest_block);
         layout_captions = ClipLayout.verticalMiddleCenter(4,tf_caption,tf_hero_name);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
