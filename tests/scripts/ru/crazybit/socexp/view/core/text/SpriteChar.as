package ru.crazybit.socexp.view.core.text
{
   import game.assets.storage.AssetStorage;
   import ru.crazybit.socexp.view.core.text.util.StringUtils;
   import starling.textures.Texture;
   
   public class SpriteChar extends TextureChar
   {
       
      
      private var _spriteName:String;
      
      public function SpriteChar(param1:String, param2:Number, param3:Number, param4:Number)
      {
         super(param2,param3,param4);
         _spriteName = param1;
         var _loc5_:String = _spriteName.split(".")[0];
         var _loc6_:Texture = AssetStorage.rsx.popup_theme.getUnsafeTexture(_loc5_);
         if(!_loc6_)
         {
            _loc6_ = Texture.fromColor(20,20,16777215);
         }
         .super.texture = _loc6_;
      }
      
      public static function tryNewSpriteChar(param1:String) : SpecialChar
      {
         var _loc8_:* = null;
         var _loc9_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         param1 = param1.replace(/\{|\}/g,"");
         var _loc2_:RegExp = /sprite:\s*\S+/g;
         var _loc5_:RegExp = /scale:\s*\S+/g;
         var _loc3_:RegExp = /dx:\s*\S+/g;
         var _loc4_:RegExp = /dy:\s*\S+/g;
         var _loc10_:Array = param1.match(_loc2_);
         if(_loc10_ && _loc10_.length)
         {
            _loc8_ = null;
            _loc9_ = 1;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc10_ = param1.match(_loc2_);
            if(_loc10_ && _loc10_.length)
            {
               _loc8_ = StringUtils.trim(_loc10_[0].split(":")[1]);
            }
            _loc10_ = param1.match(_loc5_);
            if(_loc10_ && _loc10_.length)
            {
               _loc9_ = Number(parseFloat(_loc10_[0].split(":")[1]));
            }
            _loc10_ = param1.match(_loc3_);
            if(_loc10_ && _loc10_.length)
            {
               _loc6_ = Number(parseFloat(_loc10_[0].split(":")[1]));
            }
            _loc10_ = param1.match(_loc3_);
            if(_loc10_ && _loc10_.length)
            {
               _loc6_ = Number(parseFloat(_loc10_[0].split(":")[1]));
            }
            return new SpriteChar(_loc8_,_loc9_,_loc6_,_loc7_);
         }
         return null;
      }
      
      public function get spriteName() : String
      {
         return _spriteName;
      }
   }
}
