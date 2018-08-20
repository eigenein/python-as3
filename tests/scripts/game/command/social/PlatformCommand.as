package game.command.social
{
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class PlatformCommand
   {
       
      
      public const onClientCommand:Signal = new Signal(PlatformCommand);
      
      public const onComplete:Signal = new Signal(PlatformCommand);
      
      public const onError:Signal = new Signal(PlatformCommand);
      
      public function PlatformCommand()
      {
         super();
      }
      
      public function execute() : void
      {
      }
      
      public function clientExecute(param1:Player) : void
      {
      }
   }
}
