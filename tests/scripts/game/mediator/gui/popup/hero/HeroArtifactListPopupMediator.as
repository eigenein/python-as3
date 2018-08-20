package game.mediator.gui.popup.hero
{
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.HeroArtifactListPopup;
   
   public class HeroArtifactListPopupMediator extends PopupMediator
   {
       
      
      private var _data:Vector.<PlayerHeroListValueObject>;
      
      public function HeroArtifactListPopupMediator(param1:Player)
      {
         super(param1);
         filterData();
      }
      
      public function get data() : Vector.<PlayerHeroListValueObject>
      {
         return _data;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroArtifactListPopup(this);
         return _popup;
      }
      
      public function action_select(param1:PlayerHeroListValueObject) : void
      {
         PopupList.instance.dialog_artifacts(param1.hero,null,Stash.click("hero_artifacts",_popup.stashParams));
      }
      
      private function filterData() : void
      {
         var _loc3_:int = 0;
         if(_data)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _data;
            for each(var _loc2_ in _data)
            {
               _loc2_.dispose();
            }
         }
         _data = new Vector.<PlayerHeroListValueObject>();
         var _loc4_:Vector.<PlayerHeroEntry> = player.heroes.getList();
         var _loc1_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _data.push(new PlayerHeroArtifactListValueObject(_loc4_[_loc3_].hero,player));
            _loc3_++;
         }
         _data.sort(PlayerHeroListValueObject.sort);
      }
   }
}
