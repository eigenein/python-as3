package game.data.storage.titan
{
   import game.data.storage.DescriptionBase;
   
   public class TitanDetailsDescription extends DescriptionBase
   {
      
      public static const ELEMENT_FIRE:String = "fire";
      
      public static const ELEMENT_WATER:String = "water";
      
      public static const ELEMENT_EARTH:String = "earth";
       
      
      private var _titanId:int;
      
      private var _element:String;
      
      private var _type:String;
      
      private var _isPlayable:Boolean;
      
      public function TitanDetailsDescription(param1:Object)
      {
         super();
         _titanId = param1.id;
         _element = param1.element;
         _type = param1.type;
         _isPlayable = param1.isPlayable;
      }
      
      public function get titanId() : int
      {
         return _titanId;
      }
      
      public function get element() : String
      {
         return _element;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get isPlayable() : Boolean
      {
         return _isPlayable;
      }
   }
}
