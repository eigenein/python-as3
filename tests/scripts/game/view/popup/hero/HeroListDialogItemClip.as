package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class HeroListDialogItemClip extends HeroListItemClipBase
   {
       
      
      public var button_summon:ClipButtonLabeledGlow;
      
      public var sun_glow:ClipSprite;
      
      public var NewIcon_inst0:ClipSprite;
      
      public var fragmentsProgressbar:ClipProgressBar;
      
      public var gear_list_layout_container:GuiClipLayoutContainer;
      
      public var GreenPlusIcon_inst0:ClipSprite;
      
      public var tf_fragment_count:ClipLabel;
      
      public var tf_fragment_label:ClipLabel;
      
      public var layout_fragment_count:ClipLayout;
      
      public var tf_desc_label:ClipLabel;
      
      public var layout_desc:ClipLayout;
      
      public var tf_hero_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public function HeroListDialogItemClip()
      {
         button_summon = new ClipButtonLabeledGlow();
         tf_fragment_count = new ClipLabel(true);
         tf_fragment_label = new ClipLabel(true);
         layout_fragment_count = ClipLayout.horizontalCentered(4,tf_fragment_label,tf_fragment_count);
         tf_desc_label = new ClipLabel(true);
         layout_desc = ClipLayout.horizontalCentered(0,tf_desc_label);
         tf_hero_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(2,tf_hero_name);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         fragmentsProgressbar.graphics.touchable = false;
         marker_hero_portrait_inst0.graphics.touchable = false;
         gear_list_layout_container.graphics.touchable = false;
         layout_desc.graphics.touchable = false;
         button_summon.label = Translate.translate("UI_DIALOG_HERO_LIST_SUMMON");
         layout_name.graphics.touchable = false;
         NewIcon_inst0.graphics.touchable = false;
         layout_fragment_count.graphics.touchable = false;
      }
   }
}
