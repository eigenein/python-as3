package feathers.textures
{
   import flash.geom.Rectangle;
   import starling.textures.Texture;
   
   public final class Scale3Textures
   {
      
      private static const SECOND_REGION_ERROR:String = "The size of the second region must be greater than zero.";
      
      private static const SUM_REGIONS_ERROR:String = "The combined size of the first and second regions must not be greater than the texture size.";
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      private static const HELPER_RECTANGLE:Rectangle = new Rectangle();
       
      
      private var _texture:Texture;
      
      private var _firstRegionSize:Number;
      
      private var _secondRegionSize:Number;
      
      private var _direction:String;
      
      private var _first:Texture;
      
      private var _second:Texture;
      
      private var _third:Texture;
      
      public function Scale3Textures(param1:Texture, param2:Number, param3:Number, param4:String = "horizontal")
      {
         super();
         if(param3 <= 0)
         {
            throw new ArgumentError("The size of the second region must be greater than zero.");
         }
         var _loc7_:Number = param1.scale;
         if(_loc7_ != 1)
         {
         }
         var _loc5_:Rectangle = param1.frame;
         if(!_loc5_)
         {
            _loc5_ = HELPER_RECTANGLE;
            _loc5_.setTo(0,0,param1.width,param1.height);
         }
         var _loc6_:Number = param4 == "horizontal"?_loc5_.width:Number(_loc5_.height);
         if(param2 + param3 > _loc6_)
         {
            throw new ArgumentError("The combined size of the first and second regions must not be greater than the texture size.");
         }
         this._texture = param1;
         this._firstRegionSize = param2;
         this._secondRegionSize = param3;
         this._direction = param4;
         this.initialize();
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function get firstRegionSize() : Number
      {
         return this._firstRegionSize;
      }
      
      public function get secondRegionSize() : Number
      {
         return this._secondRegionSize;
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function get first() : Texture
      {
         return this._first;
      }
      
      public function get second() : Texture
      {
         return this._second;
      }
      
      public function get third() : Texture
      {
         return this._third;
      }
      
      private function initialize() : void
      {
         var _loc16_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:* = false;
         var _loc3_:* = false;
         var _loc1_:* = false;
         var _loc14_:* = false;
         var _loc15_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc13_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:Rectangle = this._texture.frame;
         if(!_loc10_)
         {
            _loc10_ = HELPER_RECTANGLE;
            _loc10_.setTo(0,0,this._texture.width,this._texture.height);
         }
         if(this._direction == "vertical")
         {
            _loc16_ = _loc10_.height - this._firstRegionSize - this._secondRegionSize;
         }
         else
         {
            _loc16_ = _loc10_.width - this._firstRegionSize - this._secondRegionSize;
         }
         if(this._direction == "vertical")
         {
            _loc12_ = this._firstRegionSize + _loc10_.y;
            _loc6_ = _loc16_ - (_loc10_.height - this._texture.height) - _loc10_.y;
            _loc5_ = _loc12_ != this._firstRegionSize;
            _loc3_ = _loc10_.width - _loc10_.x != this._texture.width;
            _loc1_ = _loc6_ != _loc16_;
            _loc14_ = _loc10_.x != 0;
            _loc15_ = new Rectangle(0,0,this._texture.width,_loc12_);
            _loc11_ = _loc14_ || _loc3_ || _loc5_?new Rectangle(_loc10_.x,_loc10_.y,_loc10_.width,this._firstRegionSize):null;
            this._first = Texture.fromTexture(texture,_loc15_,_loc11_);
            _loc8_ = new Rectangle(0,_loc12_,this._texture.width,this._secondRegionSize);
            _loc2_ = _loc14_ || _loc3_?new Rectangle(_loc10_.x,0,_loc10_.width,this._secondRegionSize):null;
            this._second = Texture.fromTexture(texture,_loc8_,_loc2_);
            _loc9_ = new Rectangle(0,_loc12_ + this._secondRegionSize,this._texture.width,_loc6_);
            _loc4_ = _loc14_ || _loc3_ || _loc1_?new Rectangle(_loc10_.x,0,_loc10_.width,_loc16_):null;
            this._third = Texture.fromTexture(texture,_loc9_,_loc4_);
         }
         else
         {
            _loc13_ = this._firstRegionSize + _loc10_.x;
            _loc7_ = _loc16_ - (_loc10_.width - this._texture.width) - _loc10_.x;
            _loc5_ = _loc10_.y != 0;
            _loc3_ = _loc7_ != _loc16_;
            _loc1_ = _loc10_.height - _loc10_.y != this._texture.height;
            _loc14_ = _loc13_ != this._firstRegionSize;
            _loc15_ = new Rectangle(0,0,_loc13_,this._texture.height);
            _loc11_ = _loc14_ || _loc5_ || _loc1_?new Rectangle(_loc10_.x,_loc10_.y,this._firstRegionSize,_loc10_.height):null;
            this._first = Texture.fromTexture(texture,_loc15_,_loc11_);
            _loc8_ = new Rectangle(_loc13_,0,this._secondRegionSize,this._texture.height);
            _loc2_ = _loc5_ || _loc1_?new Rectangle(0,_loc10_.y,this._secondRegionSize,_loc10_.height):null;
            this._second = Texture.fromTexture(texture,_loc8_,_loc2_);
            _loc9_ = new Rectangle(_loc13_ + this._secondRegionSize,0,_loc7_,this._texture.height);
            _loc4_ = _loc5_ || _loc1_ || _loc3_?new Rectangle(0,_loc10_.y,_loc16_,_loc10_.height):null;
            this._third = Texture.fromTexture(texture,_loc9_,_loc4_);
         }
      }
   }
}
