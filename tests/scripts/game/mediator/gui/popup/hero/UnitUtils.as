package game.mediator.gui.popup.hero
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.TitanEntrySourceData;
   import game.model.user.hero.UnitEntry;
   
   public class UnitUtils
   {
       
      
      public function UnitUtils()
      {
         super();
      }
      
      public static function createDescription(param1:Object) : UnitDescription
      {
         if(param1.type == "titan")
         {
            return new TitanDescription(param1);
         }
         return new HeroDescription(param1);
      }
      
      public static function createEntry(param1:Object) : UnitEntry
      {
         var _loc2_:UnitDescription = DataStorage.hero.getUnitById(param1.id);
         if(_loc2_.unitType == "titan")
         {
            return new TitanEntry(_loc2_ as TitanDescription,new TitanEntrySourceData(param1));
         }
         return new HeroEntry(_loc2_ as HeroDescription,new HeroEntrySourceData(param1));
      }
      
      public static function createEntryValueObject(param1:UnitEntry) : UnitEntryValueObject
      {
         if(param1 is TitanEntry)
         {
            return new TitanEntryValueObject((param1 as TitanEntry).titan,param1 as TitanEntry);
         }
         return new HeroEntryValueObject((param1 as HeroEntry).hero,param1 as HeroEntry);
      }
      
      public static function createEntryValueObjectFromRawData(param1:Object) : UnitEntryValueObject
      {
         var _loc2_:UnitDescription = DataStorage.hero.getUnitById(param1.id);
         if(_loc2_.unitType == "titan")
         {
            return new TitanEntryValueObject(_loc2_ as TitanDescription,createEntry(param1) as TitanEntry);
         }
         return new HeroEntryValueObject(_loc2_ as HeroDescription,createEntry(param1) as HeroEntry);
      }
      
      public static function heroVectorToUnitVector(param1:Vector.<HeroDescription>) : Vector.<UnitDescription>
      {
         var _loc2_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function heroVectorToUnitVector2(param1:Vector.<Vector.<HeroDescription>>) : Vector.<Vector.<UnitDescription>>
      {
         var _loc5_:* = undefined;
         var _loc2_:Vector.<Vector.<UnitDescription>> = new Vector.<Vector.<UnitDescription>>();
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc5_ = new Vector.<UnitDescription>();
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _loc5_.push(_loc4_);
            }
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      public static function heroEntryVectorToUnitEntryVector(param1:Vector.<HeroEntryValueObject>) : Vector.<UnitEntryValueObject>
      {
         var _loc2_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function heroEntryVectorToUnitEntryVector2(param1:Vector.<Vector.<HeroEntryValueObject>>) : Vector.<Vector.<UnitEntryValueObject>>
      {
         var _loc5_:* = undefined;
         var _loc2_:Vector.<Vector.<UnitEntryValueObject>> = new Vector.<Vector.<UnitEntryValueObject>>();
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc5_ = new Vector.<UnitEntryValueObject>();
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for each(var _loc4_ in _loc3_)
            {
               _loc5_.push(_loc4_);
            }
            _loc2_.push(_loc5_);
         }
         return _loc2_;
      }
      
      public static function getPlayerUnitEntry(param1:Player, param2:UnitDescription) : UnitEntry
      {
         if(param2.unitType == "titan")
         {
            return param1.titans.getById(param2.id);
         }
         return param1.heroes.getById(param2.id);
      }
      
      public static function unitDescriptionVectorToUnitEntryValueObjectVector(param1:Player, param2:Vector.<UnitDescription>) : Vector.<UnitEntryValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function createUnitEntryVectorFromRawData(param1:Object) : Vector.<UnitEntryValueObject>
      {
         var _loc2_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(createEntryValueObjectFromRawData(_loc3_));
         }
         return _loc2_;
      }
      
      public static function titanVectorToIntVector(param1:Vector.<TitanDescription>) : Vector.<int>
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_.id);
         }
         return _loc2_;
      }
   }
}
