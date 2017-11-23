import './main.css';
import { Main } from './Hello.elm';
import registerServiceWorker from './registerServiceWorker';

Main.embed(document.getElementById('root'));
registerServiceWorker();
