package game.mediator.gui.popup.tower
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerBuffSelectHeroPopup;
   import idv.cjcat.signals.Signal;
   
   public class TowerBuffSelectHeroPopupMediator extends PopupMediator
   {
       
      
      private var _buff:TowerBuffValueObject;
      
      private var _selectedHero:TowerBuffSelectHeroValueObject;
      
      private var _heroes:Vector.<TowerBuffSelectHeroValueObject>;
      
      public const signal_selected:Signal = new Signal(TowerBuffSelectHeroPopupMediator);
      
      public function TowerBuffSelectHeroPopupMediator(param1:Player, param2:TowerBuffValueObject)
      {
         super(param1);
         _buff = param2;
         _heroes = param1.tower.createBuffSelectHeroList(param1,param2);
      }
      
      public function get selectedHeroId() : int
      {
         return _selectedHero.id;
      }
      
      public function get buff() : TowerBuffValueObject
      {
         return _buff;
      }
      
      public function get heroes() : Vector.<TowerBuffSelectHeroValueObject>
      {
         return _heroes;
      }
      
      public function action_selectHero(param1:TowerBuffSelectHeroValueObject) : void
      {
         _selectedHero = param1;
         signal_selected.dispatch(this);
      }
      
      public function applyBuffToHero() : void
      {
         if(_selectedHero)
         {
            _selectedHero.signal_tweenState.dispatch();
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerBuffSelectHeroPopup(this);
         return new TowerBuffSelectHeroPopup(this);
      }
   }
}
