package game.model.user.specialoffer
{
   import starling.display.DisplayObjectContainer;
   
   public class Halloween2k17SpecialOfferViewOwner implements ISpecialOfferDisplayObjectProvider
   {
      
      public static const ZEPPELIN:String = "zeppelin";
      
      public static const TOWER50:String = "tower50";
      
      public static const ARTIFACTCHEST:String = "artifactChest";
      
      public static const WORLDMAP:String = "worldmap";
      
      public static const WORLDMAP6:String = "worldmap6";
      
      public static const MOON:String = "moon";
       
      
      private var _graphics:DisplayObjectContainer;
      
      private var _data;
      
      public var ident:String;
      
      public function Halloween2k17SpecialOfferViewOwner(param1:DisplayObjectContainer, param2:*, param3:String)
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
