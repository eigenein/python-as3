package game.data.storage.particle
{
   import game.data.storage.DescriptionStorage;
   
   public class ParticleDataStorage extends DescriptionStorage
   {
       
      
      public function ParticleDataStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ParticleDataEntry = new ParticleDataEntry(param1);
         _items[_loc2_.ident] = _loc2_;
      }
      
      public function getByIdent(param1:String) : ParticleDataEntry
      {
         return _items[param1];
      }
   }
}
