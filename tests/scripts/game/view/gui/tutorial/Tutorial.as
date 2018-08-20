package game.view.gui.tutorial
{
   import game.model.user.tutorial.PlayerTutorialData;
   import starling.display.Sprite;
   
   public class Tutorial
   {
      
      private static var instance:Tutorial = new Tutorial();
       
      
      private var playerTutorialData:PlayerTutorialData;
      
      private var onTheStage:Boolean;
      
      private var queuedActionProviders:Array;
      
      protected const overlay:TutorialOverlay = new TutorialOverlay();
      
      protected const navigator:TutorialNavigator = new TutorialNavigator();
      
      protected const _events:TutorialEvents = new TutorialEvents();
      
      protected const _flags:TutorialFlags = new TutorialFlags();
      
      protected const taskExecutor:TutorialTaskExecutor = new TutorialTaskExecutor(navigator);
      
      protected const taskFactory:TutorialTaskFactory = new TutorialTaskFactory(navigator.states,taskExecutor);
      
      protected const taskManager:TutorialTaskManager = new TutorialTaskManager(_events,taskExecutor,navigator,overlay,taskFactory);
      
      public function Tutorial()
      {
         queuedActionProviders = [];
         super();
      }
      
      public static function get currentNode() : TutorialNode
      {
         return instance.navigator.currentNode;
      }
      
      public static function get events() : TutorialEvents
      {
         return instance._events;
      }
      
      public static function get flags() : TutorialFlags
      {
         return instance._flags;
      }
      
      public static function get inputIsBlocked() : Boolean
      {
         return instance && instance.overlay.inputIsBlocked || !Game.instance.stage.touchable;
      }
      
      public static function initializeView(param1:Sprite) : void
      {
         instance.overlay.initialize(param1);
         instance.navigator.initialize(instance.overlay);
      }
      
      public static function initializeData(param1:PlayerTutorialData) : void
      {
         events.subscribeAll();
         flags.initialize(instance.taskManager);
         if(instance.onTheStage)
         {
            instance.taskManager.initialize(param1);
         }
         else
         {
            instance.playerTutorialData = param1;
         }
      }
      
      public static function start() : void
      {
         instance.onTheStage = true;
         var _loc3_:int = 0;
         var _loc2_:* = instance.queuedActionProviders;
         for each(var _loc1_ in instance.queuedActionProviders)
         {
            addActionsFrom(_loc1_);
         }
         instance.queuedActionProviders = [];
         if(instance.playerTutorialData)
         {
            instance.taskManager.initialize(instance.playerTutorialData);
         }
         if(instance.navigator.currentNode != null)
         {
            events.triggerEvent_dialogNodeReached(instance.navigator.currentNode);
         }
      }
      
      public static function isCurrentNode(param1:TutorialNode) : Boolean
      {
         return instance.navigator.currentNode == param1;
      }
      
      public static function registerNode(param1:ITutorialNodePresenter) : void
      {
         instance.navigator.register(param1);
      }
      
      public static function unregister(param1:ITutorialNodePresenter) : void
      {
         instance.navigator.unregister(param1);
      }
      
      public static function addActionsFrom(param1:ITutorialActionProvider) : void
      {
         if(!instance.onTheStage)
         {
            instance.queuedActionProviders.push(param1);
            return;
         }
         instance.navigator.addActionsFrom(param1);
      }
      
      public static function removeActionsFrom(param1:ITutorialActionProvider) : void
      {
         var _loc2_:int = 0;
         if(!instance.onTheStage)
         {
            _loc2_ = instance.queuedActionProviders.indexOf(param1);
            if(_loc2_ != -1)
            {
               instance.queuedActionProviders.splice(_loc2_,1);
            }
            return;
         }
         instance.navigator.removeActionsFrom(param1);
      }
      
      public static function updateActionsFrom(param1:ITutorialActionProvider) : void
      {
         if(!instance.onTheStage)
         {
            instance.queuedActionProviders.push(param1);
            return;
         }
         instance.navigator.updateActionsFrom(param1);
      }
      
      public static function updateActions() : void
      {
         if(!instance.onTheStage)
         {
            return;
         }
         instance.navigator.updateActions();
      }
      
      public static function startCustomTask(param1:TutorialTask) : void
      {
         if(param1)
         {
            param1.initiate(instance.taskManager);
         }
      }
      
      public static function __print(param1:String, ... rest) : void
      {
      }
   }
}
