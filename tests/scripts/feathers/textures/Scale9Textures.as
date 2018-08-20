package feathers.textures
{
   import flash.geom.Rectangle;
   import starling.textures.Texture;
   
   public final class Scale9Textures
   {
      
      private static const ZERO_WIDTH_ERROR:String = "The width of the scale9Grid must be greater than zero.";
      
      private static const ZERO_HEIGHT_ERROR:String = "The height of the scale9Grid must be greater than zero.";
      
      private static const SUM_X_REGIONS_ERROR:String = "The sum of the x and width properties of the scale9Grid must be greater than the width of the texture.";
      
      private static const SUM_Y_REGIONS_ERROR:String = "The sum of the y and height properties of the scale9Grid must be greater than the height of the texture.";
      
      private static const HELPER_RECTANGLE:Rectangle = new Rectangle();
       
      
      private var _texture:Texture;
      
      private var _scale9Grid:Rectangle;
      
      private var _topLeft:Texture;
      
      private var _topCenter:Texture;
      
      private var _topRight:Texture;
      
      private var _middleLeft:Texture;
      
      private var _middleCenter:Texture;
      
      private var _middleRight:Texture;
      
      private var _bottomLeft:Texture;
      
      private var _bottomCenter:Texture;
      
      private var _bottomRight:Texture;
      
      public function Scale9Textures(param1:Texture, param2:Rectangle)
      {
         super();
         if(param2.width <= 0)
         {
            throw new ArgumentError("The width of the scale9Grid must be greater than zero.");
         }
         if(param2.height <= 0)
         {
            throw new ArgumentError("The height of the scale9Grid must be greater than zero.");
         }
         var _loc4_:Number = param1.scale;
         if(_loc4_ != 1)
         {
            param2 = param2.clone();
            param2.setTo(param2.x * _loc4_,param2.y * _loc4_,param2.width * _loc4_,param2.height * _loc4_);
         }
         var _loc3_:Rectangle = param1.frame;
         if(!_loc3_)
         {
            _loc3_ = HELPER_RECTANGLE;
            _loc3_.setTo(0,0,param1.width,param1.height);
         }
         if(param2.x + param2.width > _loc3_.width)
         {
            throw new ArgumentError("The sum of the x and width properties of the scale9Grid must be greater than the width of the texture.");
         }
         if(param2.y + param2.height > _loc3_.height)
         {
            throw new ArgumentError("The sum of the y and height properties of the scale9Grid must be greater than the height of the texture.");
         }
         this._texture = param1;
         this._scale9Grid = param2;
         this.initialize();
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function get scale9Grid() : Rectangle
      {
         return this._scale9Grid;
      }
      
      public function get topLeft() : Texture
      {
         return this._topLeft;
      }
      
      public function get topCenter() : Texture
      {
         return this._topCenter;
      }
      
      public function get topRight() : Texture
      {
         return this._topRight;
      }
      
      public function get middleLeft() : Texture
      {
         return this._middleLeft;
      }
      
      public function get middleCenter() : Texture
      {
         return this._middleCenter;
      }
      
      public function get middleRight() : Texture
      {
         return this._middleRight;
      }
      
      public function get bottomLeft() : Texture
      {
         return this._bottomLeft;
      }
      
      public function get bottomCenter() : Texture
      {
         return this._bottomCenter;
      }
      
      public function get bottomRight() : Texture
      {
         return this._bottomRight;
      }
      
      private function initialize() : void
      {
         var _loc12_:Rectangle = this._texture.frame;
         if(!_loc12_)
         {
            _loc12_ = HELPER_RECTANGLE;
            _loc12_.setTo(0,0,this._texture.width,this._texture.height);
         }
         var _loc17_:Number = this._scale9Grid.x;
         var _loc3_:Number = this._scale9Grid.width;
         var _loc15_:Number = _loc12_.width - this._scale9Grid.width - this._scale9Grid.x;
         var _loc16_:Number = this._scale9Grid.y;
         var _loc11_:Number = this._scale9Grid.height;
         var _loc6_:Number = _loc12_.height - this._scale9Grid.height - this._scale9Grid.y;
         var _loc27_:Number = _loc17_ + _loc12_.x;
         var _loc28_:Number = _loc16_ + _loc12_.y;
         var _loc24_:Number = _loc15_ - (_loc12_.width - this._texture.width) - _loc12_.x;
         var _loc23_:Number = _loc6_ - (_loc12_.height - this._texture.height) - _loc12_.y;
         var _loc13_:* = _loc27_ != _loc17_;
         var _loc8_:* = _loc28_ != _loc16_;
         var _loc22_:* = _loc24_ != _loc15_;
         var _loc2_:* = _loc23_ != _loc6_;
         var _loc21_:Rectangle = new Rectangle(0,0,_loc27_,_loc28_);
         var _loc32_:Rectangle = _loc13_ || _loc8_?new Rectangle(_loc12_.x,_loc12_.y,_loc17_,_loc16_):null;
         this._topLeft = Texture.fromTexture(this._texture,_loc21_,_loc32_);
         var _loc20_:Rectangle = new Rectangle(_loc27_,0,_loc3_,_loc28_);
         var _loc30_:Rectangle = !!_loc8_?new Rectangle(0,_loc12_.y,_loc3_,_loc16_):null;
         this._topCenter = Texture.fromTexture(this._texture,_loc20_,_loc30_);
         var _loc25_:Rectangle = new Rectangle(_loc27_ + _loc3_,0,_loc24_,_loc28_);
         var _loc5_:Rectangle = _loc8_ || _loc22_?new Rectangle(0,_loc12_.y,_loc15_,_loc16_):null;
         this._topRight = Texture.fromTexture(this._texture,_loc25_,_loc5_);
         var _loc7_:Rectangle = new Rectangle(0,_loc28_,_loc27_,_loc11_);
         var _loc1_:Rectangle = !!_loc13_?new Rectangle(_loc12_.x,0,_loc17_,_loc11_):null;
         this._middleLeft = Texture.fromTexture(this._texture,_loc7_,_loc1_);
         var _loc10_:Rectangle = new Rectangle(_loc27_,_loc28_,_loc3_,_loc11_);
         this._middleCenter = Texture.fromTexture(this._texture,_loc10_);
         var _loc14_:Rectangle = new Rectangle(_loc27_ + _loc3_,_loc28_,_loc24_,_loc11_);
         var _loc26_:Rectangle = !!_loc22_?new Rectangle(0,0,_loc15_,_loc11_):null;
         this._middleRight = Texture.fromTexture(this._texture,_loc14_,_loc26_);
         var _loc19_:Rectangle = new Rectangle(0,_loc28_ + _loc11_,_loc27_,_loc23_);
         var _loc18_:Rectangle = _loc13_ || _loc2_?new Rectangle(_loc12_.x,0,_loc17_,_loc6_):null;
         this._bottomLeft = Texture.fromTexture(this._texture,_loc19_,_loc18_);
         var _loc29_:Rectangle = new Rectangle(_loc27_,_loc28_ + _loc11_,_loc3_,_loc23_);
         var _loc31_:Rectangle = !!_loc2_?new Rectangle(0,0,_loc3_,_loc6_):null;
         this._bottomCenter = Texture.fromTexture(this._texture,_loc29_,_loc31_);
         var _loc9_:Rectangle = new Rectangle(_loc27_ + _loc3_,_loc28_ + _loc11_,_loc24_,_loc23_);
         var _loc4_:Rectangle = _loc2_ || _loc22_?new Rectangle(0,0,_loc15_,_loc6_):null;
         this._bottomRight = Texture.fromTexture(this._texture,_loc9_,_loc4_);
      }
   }
}
