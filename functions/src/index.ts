import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

exports.tasks = functions.https.onRequest(async (req, res) => {
    var final:any[] = [];
    var db = admin.firestore();
    var newelement: any;
    var listSubtarefa: any[] = [];
    var users:any[] = [];
    var numero:number = 0;
    var numeroSubtarefa:number = 0;

    await db.collection("tasks").get().then(async snapshot => {
        snapshot.forEach(async doc => {
            
          newelement = {
                "id": doc.id,
                "data": doc.data().data,
                "etiqueta": doc.data().etiqueta,
                "fase": doc.data().fase,
                "prioridade": doc.data().prioridade,
                "subtarefa": doc.data().subTarefa,
                "users": doc.data().users
            }
          
          await newelement.users.forEach((e:any) => {
              db.collection('usuarios').doc(e.id).get().then(snapshot => {              
                users.push(snapshot.data());
                numero++
              })
            });
            
          await newelement.subtarefa.forEach((s:any) => {

            db.collection('usuarios').doc(s.user.id).get().then(snapshot => {    
              s.user = snapshot.data();
              listSubtarefa.push(s);
              numeroSubtarefa++;
            })
          });

        });

        await db.collection('etiqueta').doc(newelement.etiqueta.id).get().then(snapshot => {              
          newelement.etiqueta = snapshot.data();
        })

        if(numeroSubtarefa == newelement.subtarefa.length){
          newelement.subtarefa = listSubtarefa;
          if(numero == newelement.users.length){
              newelement.users = users;
              final = final.concat(newelement);
              res.send(final);
          }
        }
          
        
    }).catch(reason => {
        res.send(reason)
    })
});

