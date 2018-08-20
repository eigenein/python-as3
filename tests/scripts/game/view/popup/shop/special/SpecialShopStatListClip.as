package game.view.popup.shop.special
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SpecialShopStatListClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var tf_stats:SpecialClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var line_1:ClipSprite;
      
      public var layout_stats:ClipLayout;
      
      private var _data:Vector.<BattleStatValueObject>;
      
      public function SpecialShopStatListClip()
      {
         tf_label = new ClipLabel();
         tf_stats = new SpecialClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         line_1 = new ClipSprite();
         layout_stats = ClipLayout.vertical(6,line_1,tf_stats);
         super();
      }
      
      public function get data() : Vector.<BattleStatValueObject>
      {
         return _data;
      }
      
      public function set data(param1:Vector.<BattleStatValueObject>) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         tf_stats.text = "";
         var _loc2_:int = _data.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            tf_stats.text = tf_stats.text + (ColorUtils.hexToRGBFormat(16442802) + _data[_loc3_].name + ColorUtils.hexToRGBFormat(16711677) + " +" + _data[_loc3_].value + "\n");
            _loc3_++;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_STATS");
         tf_stats.maxHeight = Infinity;
      }
   }
}
