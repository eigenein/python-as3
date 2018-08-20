package game.view.popup.hero
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.view.gui.components.ClipLabel;
   
   public class HeroColorNumberClip extends GuiClipNestedContainer
   {
       
      
      public var tf_number:ClipLabel;
      
      public function HeroColorNumberClip()
      {
         tf_number = new ClipLabel();
         super();
      }
      
      public static function create(param1:HeroColor, param2:Boolean = true) : HeroColorNumberClip
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(!param1)
         {
            return null;
         }
         if(param1.hasMinorIdentFraction)
         {
            _loc4_ = "hero_color_plus_" + param1.majorIdentFraction + "_";
            _loc4_ = _loc4_ + (!!param2?"18":"26");
            _loc3_ = AssetStorage.rsx.popup_theme.create(HeroColorNumberClip,_loc4_);
            _loc3_.tf_number.text = "+" + param1.minorIdentFraction;
            return _loc3_;
         }
         return null;
      }
      
      public static function createAutoSize(param1:HeroColor, param2:Boolean = true) : ClipLabel
      {
         if(!param1)
         {
            return null;
         }
         var _loc3_:Array = param1.ident.split("+");
         var _loc6_:String = "hero_color_plus_";
         var _loc5_:String = _loc3_[0];
         _loc6_ = _loc6_ + _loc5_;
         _loc6_ = _loc6_ + ("_" + (!!param2?"18":"26"));
         var _loc4_:HeroColorNumberClipAutoSize = AssetStorage.rsx.popup_theme.create(HeroColorNumberClipAutoSize,_loc6_);
         var _loc7_:String = param1.name;
         if(_loc3_.length > 1)
         {
            _loc7_ = _loc7_ + (" +" + (_loc3_.length - 1));
         }
         _loc4_.tf_number.text = _loc7_;
         return _loc4_.tf_number;
      }
      
      public function dispose() : void
      {
         if(graphics.parent)
         {
            graphics.removeFromParent();
         }
         graphics.dispose();
      }
   }
}
