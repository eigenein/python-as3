package game.data.storage.rune
{
   public class RuneTypeDescription
   {
       
      
      private var _id:int;
      
      private var _stat:String;
      
      private var _values:Vector.<Number>;
      
      public function RuneTypeDescription(param1:*)
      {
         super();
         this._id = param1.id;
         this._stat = param1.stat;
         this._values = Vector.<Number>(param1.value);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get stat() : String
      {
         return _stat;
      }
      
      public function getValueByLevel(param1:int) : Number
      {
         if(param1 <= 0)
         {
            return 0;
         }
         if(param1 > _values.length)
         {
            return _values[_values.length - 1];
         }
         return _values[param1];
      }
   }
}
