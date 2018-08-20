package game.model.user.specialoffer
{
   import starling.display.DisplayObjectContainer;
   
   public class NY2018SecretRewardOfferViewOwner implements ISpecialOfferDisplayObjectProvider
   {
      
      public static const TREE:String = "tree";
      
      public static const FIREWORKS:String = "fireworks";
      
      public static const MOON:String = "moon";
      
      public static const ZERO:String = "zero";
      
      public static const KEY_1:String = "key_1";
      
      public static const KEY_2:String = "key_2";
      
      public static const KEY_8:String = "key_3";
       
      
      private var _graphics:DisplayObjectContainer;
      
      private var _data;
      
      public var ident:String;
      
      public function NY2018SecretRewardOfferViewOwner(param1:DisplayObjectContainer, param2:*, param3:String)
      {
         super();
         this._graphics = param1;
         this.ident = param3;
         this._data = param2;
      }
      
      public function get graphics() : DisplayObjectContainer
      {
         return _graphics;
      }
      
      public function get data() : *
      {
         return _data;
      }
   }
}
