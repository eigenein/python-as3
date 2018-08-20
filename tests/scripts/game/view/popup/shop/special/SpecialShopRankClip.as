package game.view.popup.shop.special
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.HeroPortrait;
   
   public class SpecialShopRankClip extends GuiClipNestedContainer
   {
       
      
      public var tf_skill_label:ClipLabel;
      
      public var marker_hero_portrait_inst0:GuiClipContainer;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_name:ClipLayout;
      
      public var portrait:HeroPortrait;
      
      public function SpecialShopRankClip()
      {
         tf_skill_label = new ClipLabel();
         marker_hero_portrait_inst0 = new GuiClipContainer();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_name = ClipLayout.horizontalMiddleCentered(4);
         portrait = new HeroPortrait();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_skill_label.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_RANK_UP");
         marker_hero_portrait_inst0.container.addChild(portrait);
      }
   }
}
