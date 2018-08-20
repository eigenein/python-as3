package game.view.popup.test
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.TitanEntrySourceData;
   import idv.cjcat.signals.Signal;
   
   public class TeamGatherPopupMediatorAllHeroes extends TeamGatherPopupMediator
   {
       
      
      public const onHeroPicked:Signal = new Signal(UnitDescription);
      
      public const onEmptySlotsToggled:Signal = new Signal();
      
      private var includeCreeps:Boolean;
      
      public function TeamGatherPopupMediatorAllHeroes(param1:Player, param2:Vector.<UnitDescription> = null, param3:Boolean = false)
      {
         if(param2 == null)
         {
            param2 = new Vector.<UnitDescription>();
         }
         this.includeCreeps = param3;
         super(param1,param2);
      }
      
      public function setHeroes(param1:Vector.<UnitDescription>) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc10_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc3_:Vector.<UnitDescription> = this.descriptionList;
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = createHeroValueObject(param1[_loc5_]);
            if(_loc6_)
            {
               _loc7_.push(_loc6_);
               if(_loc3_.indexOf(_loc6_.desc) != -1)
               {
                  _loc6_.selected = true;
               }
            }
            _loc5_++;
         }
         var _loc8_:int = 40;
         var _loc2_:int = 10;
         var _loc9_:int = _loc7_.length;
         while(_loc9_ < _loc8_ || _loc9_ % _loc2_ > 0)
         {
            _loc7_.push(createEmptyHeroValueObject());
            _loc9_++;
         }
         _loc7_.sort(_sortVoVect);
         this._heroList = _loc7_;
         this.heroList.data = _loc7_;
      }
      
      override public function action_pick(param1:TeamGatherPopupHeroValueObject, param2:Number = 0.2) : void
      {
         super.action_pick(param1,param2);
         if(param1.desc != null)
         {
            onHeroPicked.dispatch(param1.desc);
         }
      }
      
      override protected function createHeroValueObject(param1:UnitDescription) : TeamGatherPopupHeroValueObject
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(param1 is TitanDescription)
         {
            _loc2_ = new TitanEntrySourceData();
            _loc2_.color = !!param1.isPlayable?4:1;
            _loc2_.level = !!DataStorage.hero.isPlayableHeroId(param1.id)?param1.id:1 + param1.id % 100;
            _loc2_.star = 3;
            _loc4_ = param1 as TitanDescription;
            return new TeamGatherPopupHeroValueObject(this,new TitanEntryValueObject(_loc4_,new TitanEntry(_loc4_,_loc2_)));
         }
         _loc3_ = new HeroEntrySourceData();
         _loc3_.color = !!param1.isPlayable?4:1;
         _loc3_.level = !!DataStorage.hero.isPlayableHeroId(param1.id)?param1.id:1 + param1.id % 100;
         _loc3_.star = 3;
         _loc5_ = param1 as HeroDescription;
         return new TeamGatherPopupHeroValueObject(this,new HeroEntryValueObject(_loc5_,new HeroEntry(_loc5_,_loc3_)));
      }
      
      override protected function getAllHeroes() : Vector.<UnitDescription>
      {
         if(includeCreeps)
         {
            return DataStorage.hero.getList();
         }
         return UnitUtils.heroVectorToUnitVector(DataStorage.hero.getPlayableHeroes());
      }
      
      override protected function _sortVoVect(param1:TeamGatherPopupHeroValueObject, param2:TeamGatherPopupHeroValueObject) : int
      {
         if(param1.desc && param2.desc)
         {
            return param1.desc.id - param2.desc.id;
         }
         return (!!param2.desc?1000:0) - (!!param1.desc?1000:0);
      }
   }
}
