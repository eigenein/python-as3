package ru.crazybit.socexp.view.core.text
{
   import game.assets.storage.AssetStorage;
   import ru.crazybit.socexp.view.core.text.util.StringUtils;
   import starling.textures.Texture;
   
   public class AtlasChar extends TextureChar
   {
      
      public static const ATL_GUI:String = "gui";
      
      public static const ATL_LABELS:String = "labels";
       
      
      private var _atlasName:String;
      
      private var _groupName:String;
      
      public function AtlasChar(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:uint)
      {
         super(param3,param4,param5);
         var _loc7_:Texture = AssetStorage.rsx.popup_theme.getUnsafeTexture(param2);
         if(!_loc7_)
         {
            _loc7_ = Texture.fromColor(20,20,16777215);
         }
         .super.texture = _loc7_;
      }
      
      public static function tryNewAtlasCharacter(param1:String) : SpecialChar
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc11_:* = null;
         var _loc6_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc15_:* = 0;
         var _loc14_:* = null;
         var _loc5_:* = null;
         param1 = param1.replace(/\{|\}/g,"");
         var _loc8_:RegExp = /atlas:\s*\S+\s\S+/g;
         var _loc4_:RegExp = /scale:\s*\S+/g;
         var _loc9_:RegExp = /dx:\s*\S+/g;
         var _loc10_:RegExp = /dy:\s*\S+/g;
         var _loc3_:RegExp = /frame:\s*\S+/g;
         _loc7_ = param1.match(_loc8_);
         if(_loc7_ && _loc7_.length)
         {
            _loc2_ = null;
            _loc11_ = null;
            _loc6_ = 1;
            _loc12_ = 0;
            _loc13_ = 0;
            _loc15_ = uint(0);
            _loc7_ = param1.match(_loc8_);
            if(_loc7_)
            {
               _loc14_ = StringUtils.trim(_loc7_[0].split(":")[1]);
               _loc5_ = _loc14_.split(" ");
               _loc2_ = _loc5_[0];
               _loc11_ = _loc5_[1];
            }
            _loc7_ = param1.match(_loc4_);
            if(_loc7_ && _loc7_.length)
            {
               _loc6_ = Number(parseFloat(_loc7_[0].split(":")[1]));
            }
            _loc7_ = param1.match(_loc9_);
            if(_loc7_ && _loc7_.length)
            {
               _loc12_ = Number(parseFloat(_loc7_[0].split(":")[1]));
            }
            _loc7_ = param1.match(_loc10_);
            if(_loc7_ && _loc7_.length)
            {
               _loc13_ = Number(parseFloat(_loc7_[0].split(":")[1]));
            }
            _loc7_ = param1.match(_loc3_);
            if(_loc7_ && _loc7_.length)
            {
               _loc15_ = uint(parseFloat(_loc7_[0].split(":")[1]));
            }
            return new AtlasChar(_loc2_,_loc11_,_loc6_,_loc12_,_loc13_,_loc15_);
         }
         return null;
      }
   }
}
