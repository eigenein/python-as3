package game.view.popup.dailybonus
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   import starling.display.Quad;
   
   public class DailyBonusPopupTileClip extends GuiClipNestedContainer
   {
       
      
      public var tf_day:ClipLabel;
      
      public var tf_vip:ClipLabel;
      
      public var bg:ClipButton;
      
      public var bg_current_day:ClipButton;
      
      public var icon_check:ClipSprite;
      
      public var inventory_item:PlayerInventoryItemTile;
      
      public var sun_glow:ClipSprite;
      
      public var gem_reward:DailyBonusGemRewardClip;
      
      public var vip_plate:GuiClipScale3Image;
      
      public var layout_quad:ClipLayout;
      
      public function DailyBonusPopupTileClip()
      {
         tf_day = new ClipLabel();
         tf_vip = new ClipLabel();
         bg = new ClipButton();
         bg_current_day = new ClipButton();
         icon_check = new ClipSprite();
         inventory_item = new PlayerInventoryItemTile();
         gem_reward = new DailyBonusGemRewardClip();
         vip_plate = new GuiClipScale3Image(6,28);
         layout_quad = ClipLayout.horizontal(4);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:* = null;
         super.setNode(param1);
         var _loc3_:* = false;
         vip_plate.graphics.touchable = _loc3_;
         _loc3_ = _loc3_;
         inventory_item.graphics.touchable = _loc3_;
         _loc3_ = _loc3_;
         icon_check.graphics.touchable = _loc3_;
         _loc3_ = _loc3_;
         tf_vip.touchable = _loc3_;
         tf_day.touchable = _loc3_;
         _loc2_ = new Quad(layout_quad.width,layout_quad.height,4005912);
         _loc2_.alpha = 0.7;
         layout_quad.addChild(_loc2_);
         sun_glow.graphics.touchable = false;
      }
   }
}
