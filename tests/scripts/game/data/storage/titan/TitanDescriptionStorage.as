package game.data.storage.titan
{
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionStorage;
   
   public class TitanDescriptionStorage extends DescriptionStorage
   {
       
      
      public function TitanDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc3_:int = param1.id;
         var _loc2_:TitanDescription = DataStorage.hero.getTitanById(_loc3_);
         if(_loc2_ != null)
         {
            _loc2_.initTitanData(param1);
            _items[_loc3_] = _loc2_;
         }
      }
      
      public function getTitanById(param1:uint) : TitanDescription
      {
         return DataStorage.hero.getTitanById(param1);
      }
      
      public function getList() : Vector.<TitanDescription>
      {
         var _loc2_:Vector.<TitanDescription> = new Vector.<TitanDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function getPlayableTitans() : Vector.<TitanDescription>
      {
         var _loc2_:Vector.<TitanDescription> = new Vector.<TitanDescription>();
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc1_ in _items)
         {
            if(_loc1_.isPlayable)
            {
               _loc3_++;
               _loc2_[_loc3_] = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function isPlayableTitanId(param1:int) : Boolean
      {
         return param1 >= 4000;
      }
   }
}
